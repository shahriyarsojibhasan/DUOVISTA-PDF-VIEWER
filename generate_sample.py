import os

def create_sample_pdf(filename="sample/sample_ielts_reading.pdf"):
    pages_content = [
        [
            ("IELTS ACADEMIC READING TEST - PRACTICE TEST 1", 16, True),
            ("READING PASSAGE 1: The Frontiers of Animal Cognition", 13, True),
            ("", 10, False),
            ("You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.", 9, False),
            ("---------------------------------------------------------------------------------------------------------", 9, False),
            ("", 10, False),
            ("Paragraph A", 11, True),
            ("For centuries, philosophical and scientific orthodoxy maintained that high-order reasoning and abstract", 10, False),
            ("problem solving were exclusive evolutionary attributes of the human species. Early ethologists classified non-human", 10, False),
            ("creatures as biological automatons, governed strictly by genetic hardwiring, basic instinct, and conditioned reflexes.", 10, False),
            ("Over the past quarter-century, however, cognitive ethology has undergone a profound revolution. Experimental", 10, False),
            ("breakthroughs spanning diverse taxa demonstrate that animals engage in causal reasoning, episodic memory recall,", 10, False),
            ("and future planning that challenge our traditional anthropocentric paradigms.", 10, False),
            ("", 10, False),
            ("Paragraph B", 11, True),
            ("Among the most startling revelations has been the intelligence discovered in the avian lineage, specifically", 10, False),
            ("the corvid family (crows, ravens, and jays). Historically, the colloquial insult 'bird brain' reflected the assumption", 10, False),
            ("that smaller, smooth brains lacked computational power. Yet neuroanatomists at Ruhr University Bochum uncovered that", 10, False),
            ("corvid forebrains pack an astonishing density of neurons within a specialized area termed the nidopallium.", 10, False),
            ("In quantitative cognitive trials, New Caledonian crows routinely fashion compound tools from disparate materials,", 10, False),
            ("bending wire and whittling pandanus leaves into barbed hooks to extract concealed grubs.", 10, False),
            ("", 10, False),
            ("Paragraph C", 11, True),
            ("Furthermore, laboratory experiments on Western scrub-jays have demonstrated 'mental time travel'--the ability", 10, False),
            ("to remember not just what food was cached, but precisely where and when. If a scrub-jay hides perishable wax worms", 10, False),
            ("alongside non-perishable seeds, it retrieves the perishable larvae first, switching to seeds if too much time has", 10, False),
            ("elapsed. Remarkably, if observed by a competitor while caching, the jay will return in solitude later to re-hide its", 10, False),
            ("stash in a new location, confirming an awareness of another individual's perspective.", 10, False)
        ],
        [
            ("READING PASSAGE 1 (Continued)", 14, True),
            ("---------------------------------------------------------------------------------------------------------", 9, False),
            ("", 10, False),
            ("Paragraph D", 11, True),
            ("Cognitive complexity is by no means confined to terrestrial vertebrates. In the marine biome, cephalopods—most", 10, False),
            ("prominently octopuses and cuttlefish—exhibit an entirely divergent evolutionary trajectory toward intelligence.", 10, False),
            ("Whereas human cognition is centralized in the cranium, two-thirds of an octopus's 500 million neurons reside", 10, False),
            ("within its eight semi-autonomous arms. Each limb can explore, taste, and manipulate objects independently without", 10, False),
            ("continuous instruction from the central brain.", 10, False),
            ("", 10, False),
            ("Paragraph E", 11, True),
            ("In a famous field study off the coast of Indonesia, researchers documented veined octopuses collecting discarded", 10, False),
            ("coconut shell halves from the seabed. The cephalopods transported these clumsy shells beneath their bodies across open sand,", 10, False),
            ("subsequently stacking and assembling them into an armored spherical sanctuary when threatened by predators.", 10, False),
            ("This represents one of the only verified instances of true tool usage and object manipulation in marine invertebrates.", 10, False),
            ("", 10, False),
            ("Paragraph F", 11, True),
            ("Despite these remarkable findings, comparative cognitive scientists caution against anthropomorphic bias.", 10, False),
            ("Dr. Elena Rostova, lead investigator at the Institute for Behavioral Ecology, stresses that intelligence", 10, False),
            ("should never be graded on a single human ladder. Instead, cognition is an adaptive toolkit sculpted by ecological", 10, False),
            ("pressures. Measuring non-human minds through standardized human metrics obscures the specialized evolutionary", 10, False),
            ("genius inherent to each organism's unique survival niche.", 10, False)
        ],
        [
            ("READING PASSAGE 1 - QUESTIONS 1 - 7", 14, True),
            ("---------------------------------------------------------------------------------------------------------", 9, False),
            ("", 10, False),
            ("Questions 1 - 5", 12, True),
            ("Do the following statements agree with the information given in Reading Passage 1?", 10, False),
            ("In boxes 1-5 on your IELTS Answer Sheet, write:", 10, False),
            ("   TRUE            if the statement agrees with the information", 10, False),
            ("   FALSE           if the statement contradicts the information", 10, False),
            ("   NOT GIVEN       if there is no information on this", 10, False),
            ("", 10, False),
            ("1. Early ethologists viewed animal actions as primarily driven by instinctive reflexes.", 10, False),
            ("2. The corvid forebrain possesses a layered neocortex identical to human mammals.", 10, False),
            ("3. Western scrub-jays prefer to store seeds rather than perishable insects.", 10, False),
            ("4. A scrub-jay will re-cache hidden food if it suspects a rival witnessed the original hiding.", 10, False),
            ("5. Octopuses possess fewer total neurons than most domestic animals.", 10, False),
            ("", 10, False),
            ("Questions 6 - 7", 12, True),
            ("Choose the correct letter, A, B, C or D.", 10, False),
            ("6. The author cites the phrase 'bird brain' in Paragraph B in order to:", 10, False),
            ("   A. praise the remarkable density of bird skulls.", 10, False),
            ("   B. highlight an outdated historic misconception regarding avian mental capacity.", 10, False),
            ("   C. argue that birds are smarter than all mammals.", 10, False),
            ("   D. explain how corvids manipulate wooden twigs.", 10, False),
            ("", 10, False),
            ("7. Why do veined octopuses transport coconut shells across the seabed?", 10, False),
            ("   A. To attract prospective mates during breeding seasons.", 10, False),
            ("   B. To feed on organic debris stuck to the outer husk.", 10, False),
            ("   C. To construct an armored protective bunker against predators.", 10, False),
            ("   D. To camouflage their eggs within coral reefs.", 10, False)
        ],
        [
            ("READING PASSAGE 1 - QUESTIONS 8 - 13", 14, True),
            ("---------------------------------------------------------------------------------------------------------", 9, False),
            ("", 10, False),
            ("Questions 8 - 13", 12, True),
            ("Complete the sentences below.", 10, False),
            ("Choose NO MORE THAN TWO WORDS from the passage for each answer.", 10, False),
            ("Write your answers in boxes 8-13 on your answer sheet.", 10, False),
            ("", 10, False),
            ("8. Crows in New Caledonia shape twigs and leaves into ___________ to retrieve insects.", 10, False),
            ("9. Scrub-jays exhibit an ability called ___________ that allows them to remember temporal details.", 10, False),
            ("10. A dense collection of brain cells in corvids is called the ___________.", 10, False),
            ("11. Two-thirds of an octopus's nervous system is situated within its ___________.", 10, False),
            ("12. Assembling coconut shells is a rare example of ___________ among marine invertebrates.", 10, False),
            ("13. Dr. Rostova warns scientists against ___________ when interpreting non-human behaviors.", 10, False),
            ("", 14, False),
            ("=========================================================================================", 9, False),
            ("TEST SOLVING WITH DUALVIEW EXTENSION:", 11, True),
            ("-> Pane 1 (Top / Left): View Passage (Pages 1 & 2)", 10, False),
            ("-> Pane 2 (Bottom / Right): View Questions (Pages 3 & 4)", 10, False),
            ("-> Scroll either pane independently simply by hovering your mouse pointer over it!", 10, False),
            ("-> Open the 'IELTS Notes & Answer Sheet' sidebar to write and check your answers.", 10, False),
            ("=========================================================================================", 9, False)
        ]
    ]

    objects = []
    objects.append("<< /Type /Catalog /Pages 2 0 R >>") # 1
    objects.append("") # 2: will be replaced with Pages
    objects.append("<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>") # 3
    objects.append("<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Bold >>") # 4

    page_refs = []
    for lines in pages_content:
        stream_cmds = ["BT", "50 790 Td"]
        for text, size, is_bold in lines:
            font = "/F2" if is_bold else "/F1"
            clean_text = text.replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)")
            stream_cmds.append(f"{font} {size} Tf")
            stream_cmds.append(f"({clean_text}) Tj")
            stream_cmds.append(f"0 -{size + 4} Td")
        stream_cmds.append("ET")
        
        stream_str = "\n".join(stream_cmds)
        # Normalize non-latin characters
        stream_str = stream_str.replace('\u2014', '--').replace('\u2013', '-').replace('\u2018', "'").replace('\u2019', "'").replace('\u201c', '"').replace('\u201d', '"')
        stream_bytes = stream_str.encode("latin-1")
        
        stream_obj_id = len(objects) + 1
        objects.append(f"<< /Length {len(stream_bytes)} >>\nstream\n{stream_str}\nendstream")
        
        page_obj_id = len(objects) + 1
        page_refs.append(f"{page_obj_id} 0 R")
        objects.append(
            f"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] "
            f"/Contents {stream_obj_id} 0 R "
            f"/Resources << /Font << /F1 3 0 R /F2 4 0 R >> >> >>"
        )

    kids_str = " ".join(page_refs)
    objects[1] = f"<< /Type /Pages /Kids [{kids_str}] /Count {len(page_refs)} >>"

    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with open(filename, "wb") as f:
        f.write(b"%PDF-1.4\n")
        xref = [0]
        pos = len(b"%PDF-1.4\n")
        for i, obj in enumerate(objects, 1):
            xref.append(pos)
            entry = f"{i} 0 obj\n{obj}\nendobj\n".encode("latin-1")
            f.write(entry)
            pos += len(entry)
        
        xref_pos = pos
        f.write(f"xref\n0 {len(objects) + 1}\n0000000000 65535 f \n".encode("latin-1"))
        for x in xref[1:]:
            f.write(f"{x:010d} 00000 n \n".encode("latin-1"))
        f.write(f"trailer\n<< /Size {len(objects) + 1} /Root 1 0 R >>\nstartxref\n{xref_pos}\n%%EOF\n".encode("latin-1"))

if __name__ == "__main__":
    create_sample_pdf()
    print("Sample PDF generated successfully!")
