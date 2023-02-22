import { Router } from "express";
import { getCategories } from "../controllers/home";

const route = Router();

route.get("/categories", async (req, res) => {
  const request = await getCategories();
  return res.status(request.status).json(request);
});

export { route as apiHomeRoutes };
