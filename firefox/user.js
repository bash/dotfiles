// Disable sponsored content on Firefox Home (Activity Stream)
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "");

// Pocket
user_pref("extensions.pocket.enabled", false);

// AI Chat
user_pref("browser.ml.chat.enabled", false);

// No warning when opening about:config
user_pref("browser.aboutConfig.showWarning", false);

// No recommendations
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.discovery.sites", "");
user_pref("extensions.getAddons.discovery.api_url", "");
