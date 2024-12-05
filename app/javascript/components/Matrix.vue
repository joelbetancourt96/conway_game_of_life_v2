<template>
  <div>
    <h2>Generazione: {{ generation }}</h2>
    <table>
      <tr v-for="(row, rowIndex) in grid" :key="rowIndex">
        <td v-for="(cell, colIndex) in row" :key="colIndex">
          <span :class="cellClass(cell)"></span>
        </td>
      </tr>
    </table>
    <button @click="startGame">Start</button>
  </div>
</template>

<script>
export default {
  props: {
    initialGrid: Array,
    initialGeneration: Number,
  },
  mounted() {
    consumer.subscriptions.create("GameChannel", {
      received(data) {
        this.grid = data.grid;
        this.generation = data.generation;
      },
    });
  },
  data() {
    return {
      grid: this.initialGrid,
      generation: this.initialGeneration,
    };
  },
  methods: {
    async startGame() {
      try {
        const response = await fetch("/next_generation", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ grid: this.grid }),
        });
        const data = await response.json();
        this.grid = data.grid;
        this.generation = data.generation;
      } catch (error) {
        console.error("Errore durante l'aggiornamento:", error);
      }
    },
    cellClass(cell) {
      return cell === "*" ? "alive" : "dead";
    },
  },
};
</script>

<style>
.alive {
  width: 20px;
  height: 20px;
  background-color: green;
}
.dead {
  width: 20px;
  height: 20px;
  background-color: lightgrey;
}
</style>
