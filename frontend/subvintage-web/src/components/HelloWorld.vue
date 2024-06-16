<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <img :src="logo" alt="Logo">
  </div>
</template>

<script>
import logo from '@/assets/logo.png'; // Importa la imagen desde el directorio assets

export default {
  name: 'HelloWorld',
  props: {
    msg: String,
  },
  data() {
    return {
      logo, // Asigna la imagen importada a una propiedad del data
    };
  },
};
</script>

<style scoped>
.hello {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
