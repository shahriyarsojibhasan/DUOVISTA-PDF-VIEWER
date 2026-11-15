// Background Service Worker for DuoVista PDF Studio (Manifest V3)
// Created by Shahriyar Sojib Hasan — Free for Students Worldwide

function shouldInterceptPdf(url) {
  if (!url) return false;
  const viewerUrl = chrome.runtime.getURL("viewer.html");
  if (url.startsWith(viewerUrl)) return false;
  // Match .pdf files (ignore other files)
  return /\.pdf($|[?#])/i.test(url);
}

function redirectToViewer(tabId, originalUrl) {
  const viewerUrl = chrome.runtime.getURL("viewer.html");
  const targetViewerUrl = `${viewerUrl}?file=${encodeURIComponent(originalUrl)}`;
  chrome.tabs.update(tabId, { url: targetViewerUrl });
}

// 1. WebNavigation Interceptor (Primary - catches before page loads)
chrome.webNavigation.onBeforeNavigate.addListener((details) => {
  if (details.frameId !== 0) return;
  if (shouldInterceptPdf(details.url)) {
    redirectToViewer(details.tabId, details.url);
  }
});

// 2. Tabs Interceptor (Fallback for local file:/// and direct address bar navigations)
chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  if (changeInfo.url && shouldInterceptPdf(changeInfo.url)) {
    redirectToViewer(tabId, changeInfo.url);
  }
});

// Open viewer when extension icon in toolbar is clicked
chrome.action.onClicked.addListener((tab) => {
  chrome.tabs.create({
    url: chrome.runtime.getURL("viewer.html")
  });
});

// Context menus
chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: "open_duovista_tab",
    title: "Open DuoVista PDF Studio",
    contexts: ["action", "page"]
  });

  chrome.contextMenus.create({
    id: "open_link_in_duovista",
    title: "Open PDF in DuoVista Split Viewer",
    contexts: ["link"]
  });
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "open_duovista_tab") {
    chrome.tabs.create({
      url: chrome.runtime.getURL("viewer.html")
    });
  } else if (info.menuItemId === "open_link_in_duovista") {
    const targetUrl = info.linkUrl;
    chrome.tabs.create({
      url: chrome.runtime.getURL(`viewer.html?file=${encodeURIComponent(targetUrl)}`)
    });
  }
});
