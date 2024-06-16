<template>
    <div>
      <h1>Users Created</h1>
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">{{ error.message }}</div>
      <div v-else>
        <div v-for="user in users" :key="user.id">
          <p>ID: {{ user.id }}</p>
          <p>User Management ID: {{ user.UserManagement_id }}</p>
          <p>Username: {{ user.username }}</p>
          <p>Block Number: {{ user.blockNumber }}</p>
          <p>Block Timestamp: {{ user.blockTimestamp }}</p>
          <p>Transaction Hash: {{ user.transactionHash }}</p>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { fetchUserCreateds } from '@/graphql';
  
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
        const data = await fetchUserCreateds();
        console.log(data);
        this.users = data;
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
  