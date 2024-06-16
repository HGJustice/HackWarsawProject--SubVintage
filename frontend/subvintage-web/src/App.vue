<template>
  <div id="app">
    <header>
      <!-- Barra de navegación -->
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
          <router-link to="/" class="navbar-brand">SubVintage</router-link>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item">
                <router-link to="/" class="nav-link">Inicio</router-link>
              </li>
              <li class="nav-item">  <router-link to="/ProductDetail" class="nav-link">ProductDetail</router-link> </li>
                <li class="nav-item">  <router-link to="/OrderDetail" class="nav-link">OrderDetail</router-link> </li>
                  <li class="nav-item">  <router-link to="/UserCreatedList" class="nav-link">UserCreatedList</router-link> </li>
                    <li class="nav-item">  <router-link to="/ListingCreatedList" class="nav-link">ListingCreatedList</router-link> </li>
                      <li class="nav-item">  <router-link to="/CreateUser" class="nav-link">CreateUser</router-link> </li>
                        <li class="nav-item">  <router-link to="/MarketPlace" class="nav-link">MarketPlace</router-link> </li>
                          <li class="nav-item">  <router-link to="/CreateListing" class="nav-link">CreateListing</router-link> </li>
              <!-- Otras rutas si es necesario -->
            </ul>
          </div>
        </div>
      </nav>
    </header>

    <!-- Contenido principal -->
    <main class="py-4">
      <router-view></router-view>
    </main>

    <footer class="text-center mt-4">
      <!-- Pie de página -->
      <p>&copy; {{ new Date().getFullYear() }} SubVintage. All rights reserved.</p>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'App',
};
</script>

<style>
/* Estilos globales si es necesario */
</style>
