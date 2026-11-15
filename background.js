// Background Service Worker for DuoVista PDF (Manifest V3)
// Created by Shahriyar Sojib Hasan — Free for Students Worldwide

// Intercept navigations to PDF files to act as Default PDF Viewer
chrome.webNavigation.onBeforeNavigate.addListener((details) => {
  if (details.frameId !== 0) return;

  const url = details.url;
  if (!url) return;

  const viewerUrl = chrome.runtime.getURL("viewer.html");
  if (url.startsWith(viewerUrl)) return;

  const isPdf = /\.pdf($|[?#])/i.test(url);
  if (isPdf) {
    const targetViewerUrl = `${viewerUrl}?file=${encodeURIComponent(url)}`;
    chrome.tabs.update(details.tabId, { url: targetViewerUrl });
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
