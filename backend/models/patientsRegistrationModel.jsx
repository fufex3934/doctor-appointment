const mongoose = require("mongoose");

const patientSchema = mongoose.Schema(
  {
    fullName: { type: String, required: true },
    email: { type: String, required: true },
    birthDate: { type: Date, required: true },
    password: { type: String, required: true },
  },
 
);

module.exports = mongoose.model("Patient", patientSchema);
