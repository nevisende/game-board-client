import axios from "axios";

export const getHighRankedPlayers = async () => {
  let players = await axios.get(`http://localhost:4400/api/v1/leader-board`);

  return players.data.data;
};
