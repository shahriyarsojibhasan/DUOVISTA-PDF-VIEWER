from PIL import Image, ImageDraw, ImageFont
import os

def create_icon(size, filename):
    # Create image with RGBA
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Rounded rectangle background with modern indigo/blue gradient
    corner_radius = int(size * 0.22)
    padding = max(1, int(size * 0.04))
    
    # Draw background rounded rect
    draw.rounded_rectangle(
        [padding, padding, size - padding, size - padding],
        radius=corner_radius,
        fill=(37, 99, 235) # Vibrant Blue
    )
    
    # Inner layout representing split screen
    # Two panels: Left and Right (or Top and Bottom)
    gap = max(2, int(size * 0.06))
    inner_pad = max(2, int(size * 0.16))
    
    # Left Pane (white card)
    left_x1 = inner_pad
    left_y1 = inner_pad
    left_x2 = size // 2 - gap // 2
    left_y2 = size - inner_pad
    draw.rounded_rectangle(
        [left_x1, left_y1, left_x2, left_y2],
        radius=max(2, int(size * 0.08)),
        fill=(255, 255, 255)
    )
    
    # Right Pane (accented light card)
    right_x1 = size // 2 + gap // 2
    right_y1 = inner_pad
    right_x2 = size - inner_pad
    right_y2 = size - inner_pad
    draw.rounded_rectangle(
        [right_x1, right_y1, right_x2, right_y2],
        radius=max(2, int(size * 0.08)),
        fill=(224, 242, 254) # Light cyan/blue
    )
    
    # Text lines simulation on Left Pane (Passage)
    if size >= 48:
        line_pad = max(2, int((left_x2 - left_x1) * 0.18))
        line_w = left_x2 - left_x1 - 2 * line_pad
        for i in range(4):
            ly = left_y1 + int((i + 1.2) * (size * 0.12))
            if ly < left_y2 - 6:
                cur_w = line_w if i % 2 == 0 else int(line_w * 0.75)
                draw.rectangle([left_x1 + line_pad, ly, left_x1 + line_pad + cur_w, ly + max(1, int(size * 0.03))], fill=(148, 163, 184))
                
        # Question marks / check lines simulation on Right Pane
        r_pad = max(2, int((right_x2 - right_x1) * 0.18))
        r_w = right_x2 - right_x1 - 2 * r_pad
        for i in range(3):
            ry = right_y1 + int((i + 1.5) * (size * 0.15))
            if ry < right_y2 - 6:
                # checkbox bullet
                bullet_size = max(2, int(size * 0.04))
                draw.rectangle([right_x1 + r_pad, ry, right_x1 + r_pad + bullet_size, ry + bullet_size], fill=(14, 165, 233))
                draw.rectangle([right_x1 + r_pad + bullet_size + 3, ry, right_x1 + r_pad + r_w, ry + max(1, int(size * 0.03))], fill=(56, 189, 248))

    os.makedirs(os.path.dirname(filename), exist_ok=True)
    img.save(filename, "PNG")

if __name__ == "__main__":
    create_icon(16, "icons/icon16.png")
    create_icon(48, "icons/icon48.png")
    create_icon(128, "icons/icon128.png")
    print("Icons generated successfully!")
