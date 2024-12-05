import consumer from "./consumer";

consumer.subscriptions.create("GameChannel", {
  connected() {
    console.log("Connected to GameChannel");
  },

  disconnected() {
    console.log("Disconnected from GameChannel");
  },

  received(data) {
    // Aggiorna la griglia quando ricevi dati
    const gridElement = document.getElementById("grid");
    gridElement.innerHTML = data.grid_html; // Aggiorna la griglia con il nuovo HTML
  },
});