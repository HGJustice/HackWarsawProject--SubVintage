<template>
  <div>
    <button @click="buyListing">Buy Listing</button>
    <button @click="createListing">Create Listing</button>
    <button @click="loadListing">Load Listing</button>
  </div>
</template>

<script>
import Web3 from "web3";
import MarketplaceABI from "@/contracts/Marketplace.json"; // Asegúrate de tener tu ABI en esta ruta

export default {
  data() {
    return {
      account: null,
      web3: null,
      contract: null,
      contractAddress: "0xa68ec9C82e98011aD043E4cece96AB49Ba345A82" // Reemplaza con la dirección de tu contrato
    };
  },
  async created() {
    await this.initWeb3();
  },
  methods: {
    async initWeb3() {
      if (window.ethereum) {
        this.web3 = new Web3(window.ethereum);
        try {
          await window.ethereum.enable();
          const accounts = await this.web3.eth.getAccounts();
          this.account = accounts[0];
          this.contract = new this.web3.eth.Contract(MarketplaceABI, this.contractAddress);
        } catch (e) {
          console.error(e);
        }
      } else if (window.web3) {
        this.web3 = new Web3(window.web3.currentProvider);
        this.contract = new this.web3.eth.Contract(MarketplaceABI, this.contractAddress);
        const accounts = await this.web3.eth.getAccounts();
        this.account = accounts[0];
      } else {
        console.error("Non-Ethereum browser detected. You should consider trying MetaMask!");
      }
    },
    async buyListing() {
      const listingId = 1; // Reemplaza con el ID del listing que quieres comprar
      const price = this.web3.utils.toWei('0.1', 'ether'); // Reemplaza con el precio correcto
      try {
        await this.contract.methods.buyListing(listingId).send({ from: this.account, value: price });
        alert("Listing bought successfully");
      } catch (e) {
        console.error(e);
      }
    },
    async createListing() {
      const title = "Sample Listing";
      const description = "This is a sample description.";
      const price = this.web3.utils.toWei('0.1', 'ether'); // Reemplaza con el precio
      try {
        await this.contract.methods.createListing( title, description, price).send({ from: this.account });
        alert("Listing created successfully");
      } catch (e) {
        console.error(e);
      }
    },
    async loadListing() {
      const listingID = 1; // Reemplaza con el ID del listing que quieres cargar
      try {
        const listing = await this.contract.methods.getListing(listingID).call();
        console.log(listing);
      } catch (e) {
        console.error(e);
      }
    }
  }
};
</script>

<style scoped>
/* Añade tus estilos aquí */
</style>
