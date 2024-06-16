<template>
    <div>
      <h1>Listings Bought</h1>
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">{{ error.message }}</div>
      <div v-else>
        <div v-for="listing in listings" :key="listing.id">
          <p>ID: {{ listing.id }}</p>
          <p>Marketplace ID: {{ listing.Marketplace_id }}</p>
          <p>Buyer: {{ listing.buyer }}</p>
          <p>Escrow Contract: {{ listing.escrowContract }}</p>
          <p>Block Number: {{ listing.blockNumber }}</p>
          <p>Block Timestamp: {{ listing.blockTimestamp }}</p>
          <p>Transaction Hash: {{ listing.transactionHash }}</p>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { fetchListingBoughts } from '@/graphql';
  
  export default {
    data() {
      return {
        listings: [],
        loading: true,
        error: null
      };
    },
    async created() {
      try {
        const data = await fetchListingBoughts();
        this.listings = data;
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
  