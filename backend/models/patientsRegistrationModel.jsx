const mongoose = require('mongoose');

const patientSchema = mongoose.Schema({
    _id: mongoose.Types.ObjectId,
    fullName: { type: String, required: true },
    email: { type: String, required: true },
    birthDate: { type: String, required: true },
    password: { type: String, required: true },
}, {
    collection: "Patient"
});

module.exports = mongoose.model('Patient', patientSchema);