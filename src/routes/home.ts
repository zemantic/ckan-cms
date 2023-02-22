import { Router } from "express";
import {
  getCategories,
  getResearchDataCount,
  getResearcherCount,
} from "../controllers/home";

const route = Router();

route.get("/categories", async (req, res) => {
  const request = await getCategories();
  return res.status(request.status).json(request);
});

route.get("/stats", async (req, res) => {
  const researchDataCount = await getResearchDataCount();
  const researcherCount = await getResearcherCount();

  if (researchDataCount.status !== 200 || researcherCount.status !== 200) {
    return res.status(500).json({
      status: 500,
      data: {
        researchDataCount: researchDataCount,
        researcherCount: researcherCount,
      },
      msg: "error occured when fetching some or all data from the backend",
    });
  }
  return res.status(200).json({
    status: 200,
    msg: "stats fetched successfully",
    data: {
      researchDataCount: researchDataCount,
      researcherCount: researcherCount,
    },
  });
});

export { route as apiHomeRoutes };
