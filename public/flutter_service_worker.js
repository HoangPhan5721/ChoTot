'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "58ef370c5f915e83fe0942f63d3f2911",
"assets/AssetManifest.bin.json": "9d1dc1cbe6b3f1c674f75183d4f711fb",
"assets/AssetManifest.json": "ea09cf1948d39707fa6979b3265a4b6c",
"assets/assets/fonts/Inter-Bold.otf": "d759e235e88e47f838062c7ab97308b1",
"assets/assets/fonts/Inter-Medium.otf": "ef3d193e6a6ad033724c7872aec1cff7",
"assets/assets/fonts/Inter-Regular.otf": "76e872bc911c3d908aeaf31b2c16bc63",
"assets/assets/fonts/Inter-SemiBold.otf": "0cdf90c9b53a236426ae986645a81ec3",
"assets/assets/fonts/PoppinsBold.ttf": "7940efc40d8e3b477e16cc41b0287139",
"assets/assets/fonts/PoppinsMedium.ttf": "a4e11dda40531debd374e4c8b1dcc7f4",
"assets/assets/images/A.java": "a7fc394b606ccdfd28e393f42e571be2",
"assets/assets/images/Avatar.png": "8cf662f7dac0b13ccef79d70e9633e52",
"assets/assets/images/banner.png": "6c8ad87d024b6cf1e1921bf5692b9492",
"assets/assets/images/cart1.png": "04e18fb65b68fc181e09a47491f2f27e",
"assets/assets/images/chat-quote-line.png": "f0f9d1a8901a6c4708bca51564c3d5e2",
"assets/assets/images/contacts-line.png": "f3ad3d052094e9db174cc0c9d11680ee",
"assets/assets/images/discord.png": "7f85f5eb36bc19bfdf0e0f7422228df5",
"assets/assets/images/edit-line.png": "fe0d8c9245d443a3ed824dfda1a5620c",
"assets/assets/images/facebook.png": "19aff7ae8af52bd3a265f9546e90c981",
"assets/assets/images/Frame%25201.png": "b2675b2ba2597f37699f172bc6b0869c",
"assets/assets/images/Frame%25202.png": "8fb59abbc3cac4f342813f30d790747d",
"assets/assets/images/Frame%25203.png": "9040bc252216dd76db5fcd3ad6de36a0",
"assets/assets/images/Frame%25204.png": "51daa3cc2149225c244b6effa5ad01bb",
"assets/assets/images/google.png": "1136a393458ecd3ca82fb13a0e751f56",
"assets/assets/images/home.png": "617fda418df492d68ca1fe65b86ab86c",
"assets/assets/images/home1.png": "3ebe1b2c91aab441eb53609367e380ad",
"assets/assets/images/home2.png": "e29ff474ceed07b1828ec1f80c18262c",
"assets/assets/images/home3.png": "e29ff474ceed07b1828ec1f80c18262c",
"assets/assets/images/home4.png": "e29ff474ceed07b1828ec1f80c18262c",
"assets/assets/images/image10.png": "4dc2bb4f49ee2dba05fd34e5d9d3da7a",
"assets/assets/images/image7.png": "97fa3fef9b32a93cdd97a5d4db0ee53c",
"assets/assets/images/image8.png": "be46e597c5fd03823f61e31356597703",
"assets/assets/images/image9.png": "5b20dbff4e47a9ffeb489ab12aab4da9",
"assets/assets/images/img_arrow_left.png": "f3cd83154ed2e365a5c6ff50abd9a89e",
"assets/assets/images/img_email.png": "6b51f8a8b4636bb873ba733a8b5c90c5",
"assets/assets/images/img_product.png": "2888ce01190adde8f2a3feb2ee90daea",
"assets/assets/images/img_product_1.png": "aeaee92b9bbf602c8d856f34db3b396c",
"assets/assets/images/img_product_2.png": "8a3fa476d7aef68a4bba27639d76f607",
"assets/assets/images/img_product_3.png": "6f120a5eaa88d2355843a06b65e7afd9",
"assets/assets/images/lock-2-line.png": "f221efb63d10af2bbe367a0b263ff0b1",
"assets/assets/images/lock.png": "ff1e03b66c99a1c661a0650ec0ecb1aa",
"assets/assets/images/manage.png": "30f5b57a0ab8d8f4d36d6efd65517191",
"assets/assets/images/manage2.png": "30f5b57a0ab8d8f4d36d6efd65517191",
"assets/assets/images/manage3.png": "30f5b57a0ab8d8f4d36d6efd65517191",
"assets/assets/images/manage4.png": "7255724ce011ffc729f110a0239ae0d9",
"assets/assets/images/mental-health-line.png": "c0878a6dd5bf51afa0fc79e509e940a7",
"assets/assets/images/notification-3-line.png": "e34d357dfaeb19d978c35b7327333bbd",
"assets/assets/images/post.png": "0f8f26c41d512da37a1f0caec4321b83",
"assets/assets/images/post2.png": "b1fd87a9509889270b929893bf074254",
"assets/assets/images/post3.png": "0f8f26c41d512da37a1f0caec4321b83",
"assets/assets/images/post4.png": "0f8f26c41d512da37a1f0caec4321b83",
"assets/assets/images/product.jfif": "54dee071e498fca0d98066547467dd74",
"assets/assets/images/profile-line.png": "2246a4f94c6c915ef2ca8ce015462e51",
"assets/assets/images/projector-2-line.png": "e6e1e8e2ead5168c2a9ea317c9916908",
"assets/assets/images/Radio.png": "b1c097a7b05646ad09938908c63a31a5",
"assets/assets/images/search1.png": "4b46854d905ce4bf6266d043c40df1d6",
"assets/assets/images/translate-2.png": "21856bc7ceef9d63e0d761934276eb2f",
"assets/assets/images/user.png": "fc6c181122eb15c1e7581081685b4303",
"assets/assets/images/user1.png": "03f19b5c7d5085545fa1928be7d6e8d2",
"assets/assets/images/user2.png": "fc6c181122eb15c1e7581081685b4303",
"assets/assets/images/user3.png": "f5eb2498f31ec11277eca166e13edd67",
"assets/assets/images/user4.png": "fc6c181122eb15c1e7581081685b4303",
"assets/assets/images/Vector.png": "8695e9db8bea9f9fa5d7977ea2688ddd",
"assets/assets/images/vertical.png": "8a96ab7ad0cee2b5a34cba0ee2e03949",
"assets/FontManifest.json": "79b3480acbcdeeae76f9914fff4deb8b",
"assets/fonts/MaterialIcons-Regular.otf": "a3892d9f87c62ad5e1cd3369cfe5170d",
"assets/NOTICES": "713689adb30676e835a0115f890ffbd6",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "1403fe802c209ac4dcd3d89b17917d85",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "e77e82dfd86da004f7187e2c8708e8fc",
"/": "e77e82dfd86da004f7187e2c8708e8fc",
"main.dart.js": "4e8fbc08966d4a7fecd9021de86c2785",
"manifest.json": "f2a8429f4e267ce6f80ba1d83fe152c6",
"version.json": "6067cfdb9c675261b86700094965d869"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
