import { prisma } from "../helpers/prisma";

export const getResearchDataCount = async () => {
  const researchGroupName = await prisma.zemantic_setting
    .findUnique({
      where: {
        key: "researchGroup",
      },
    })
    .catch((e) => {
      return new Error(e);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });

  if (researchGroupName instanceof Error) {
    return {
      status: 500,
      message: "an error occured when getting research group name",
      data: null,
    };
  }

  if (!researchGroupName) {
    return {
      status: 500,
      message: "research group name not set",
      data: null,
    };
  }

  const researchGroup = await prisma.group
    .findUnique({
      where: {
        name: researchGroupName.value,
      },
    })
    .catch((e) => {
      return new Error(e);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });

  if (researchGroup instanceof Error) {
    return {
      status: 500,
      msg: "an error occured when getting research group",
      data: null,
    };
  }

  if (!researchGroup) {
    return {
      status: 500,
      msg: `research group not found for name ${researchGroupName.value}`,
      data: null,
    };
  }

  const researchData = await prisma.member
    .count({
      where: {
        state: "active",
        table_name: "package",
        capacity: "public",
        group_id: researchGroup.id,
      },
    })
    .catch((e) => {
      return new Error(e);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });

  if (researchData instanceof Error) {
    return {
      state: 500,
      msg: "an error occured when counting research datasets",
      data: null,
    };
  }

  return {
    state: 200,
    msg: "research data retrieved",
    data: researchData,
  };
};

export const getResearcherCount = async () => {
  const researcherCount = await prisma.zemantic_user
    .aggregate({
      _count: {
        id: true,
      },
    })
    .catch((e) => {
      return new Error(e);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });

  if (researcherCount instanceof Error) {
    return {
      status: 500,
      msg: "an unexpected error occured in getting user count",
      data: null,
    };
  }

  return {
    status: 200,
    msg: "researcher count retrieved",
    data: researcherCount,
  };
};

// Get categories to be displayed at the home page
export const getCategories = async () => {
  const categories = await prisma.group
    .findMany({
      where: {
        state: "active",
        approval_status: "approved",
      },
      select: {
        name: true,
        title: true,
      },
    })
    .catch((e) => {
      return new Error(e);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });

  if (categories instanceof Error) {
    return {
      status: 500,
      message: "an usexpected error occured when getting categories",
      data: null,
    };
  }

  return {
    status: 200,
    message: "categories fetched",
    data: {
      categories: categories,
    },
  };
};
