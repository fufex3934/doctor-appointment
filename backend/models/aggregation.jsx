const pipeline = [
    {
      $unwind: "$Request", // Unwind the Request array
    },
    {
      $lookup: {
        from: "patients", // Name of the patients collection
        localField: "Request.RequesterId",
        foreignField: "_id",
        as: "patientInfo",
      },
    },
    {
      $unwind: "$patientInfo",
    },
    {
      $project: {
        _id: 1,
        fullName: 1,
        specialization: 1,
        Experience: 1,
        email: 1,
        Location: 1,
        Patients: 1,
        password: 1,
        requesterId: "$Request.RequesterId", // Include the RequesterId
        overview: "$Request.Overview", // Include the Overview
        patientInfo: 1, // Include the patient information
      },
    },
  ];
  
  module.exports = pipeline;
  