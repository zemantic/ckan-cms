require("dotenv").config();

import express from "express";
import path from "path";
import { apiHomeRoutes } from "./routes/home";

const app = express();
const port = process.env.PORT || 3000;

app.set("view engine", "pug");
app.set("views", path.join(__dirname, "../views"));

app.use(express.static(path.join(__dirname, "public")));

app.get("/", (req, res) => {
  res.send("CKAN CMS");
});

app.use("/api/home", apiHomeRoutes);

app.get("/submit", (req, res) => {
  res.render("submit", { title: "Submit your dataset" });
});

app.listen(port, () => {
  console.log(`CKAN CMS is running on port ${port}`);
});
