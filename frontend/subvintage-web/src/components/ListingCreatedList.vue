<template>
    <div>
      <h1>Users Created</h1>
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">{{ error.message }}</div>
      <div v-else>
        <div v-for="list in listings" :key="list.id">
          <p>Marketplace_id: {{ list.Marketplace_id }}</p>
          <p>blockNumber: {{ list.blockNumber }}</p>
          <p>blockTimestamp: {{ list.blockTimestamp }}</p>
          <p>user.descriptionr: {{ list.description }}</p>
          <p> user.id: {{ list.id }}</p>
          <p>owner: {{ list.owner }}</p>
          <p>price: {{ list.price }}</p>
          <p>transactionHash: {{ list.transactionHash }}</p>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { fetchListingCreateds } from '@/graphql';
  
  export default {
    data() {
      return {
        users: [],
        loading: true,
        error: null
      };
    },
    async created() {
      try {
        const data = await fetchListingCreateds();
        this.listings = data;
        console.log(data);
      } catch (error) {
        this.error = error;
      } finally {
        this.loading = false;
      }
    }
  };
  </script>
  
  <style scoped>
  /* Estilos para tu componente */
  </style>
  