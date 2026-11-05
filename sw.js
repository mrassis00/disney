const CACHE_NAME = 'orlando-2026-v5';
const ASSETS_TO_CACHE = [
  './',
  './index.html',
  './app_roteiro_orlando.html',
  './manifest.json',
  './maps/universal_twopark_flow.jpg',
  './maps/magic_kingdom_master_map.jpg',
  './maps/epic_universe_flow.jpg',
  './maps/animal_kingdom_flow.jpg',
  './maps/hollywood_studios_flow.jpg',
  './maps/epcot_park_flow.jpg',
  './maps/seaworld_park_flow.jpg'
];

// Instalação do Service Worker e gravação do Cache
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('[Service Worker] Pré-carregando todos os ativos e mapas para uso offline...');
      return cache.addAll(ASSETS_TO_CACHE);
    }).then(() => self.skipWaiting())
  );
});

// Ativação e limpeza de caches antigos
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((name) => {
          if (name !== CACHE_NAME) {
            console.log('[Service Worker] Removendo cache antigo:', name);
            return caches.delete(name);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// Interceptação de requisições: Stale-While-Revalidate (Sempre atualizado na web + Instantâneo offline)
self.addEventListener('fetch', (event) => {
  if (event.request.method !== 'GET') return;

  event.respondWith(
    caches.match(event.request).then((cachedResponse) => {
      // Busca versão nova da rede em background para manter sempre atualizado
      const fetchPromise = fetch(event.request).then((networkResponse) => {
        if (networkResponse && networkResponse.status === 200) {
          const responseToCache = networkResponse.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseToCache);
          });
        }
        return networkResponse;
      }).catch(() => {
        // Se estiver offline e sem rede, o catch não quebra o app
        console.log('[Service Worker] Operando em modo offline para:', event.request.url);
      });

      // Retorna o cache instantâneo se existir, ou espera o fetch da rede
      return cachedResponse || fetchPromise;
    })
  );
});
