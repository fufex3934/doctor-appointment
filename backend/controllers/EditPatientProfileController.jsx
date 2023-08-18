const Patient = require("../models/patientsRegistrationModel.jsx");
const multer = require("multer");
const upload = multer({ dest: "uploads/" });

//register patient
const EditPatientProfile = async (req, res) => {
  const id = req.params.id;
  const { name, profileImage, Age, Gender, DOB, Fathers_Name, Mothers_Name, Blood_Type, Weight, Height, Alergy, Place, Phone, Alt_Phone ,Email,userId } = req.body;
  const list= ['nameAndImage', 'profileInfo', 'addressInfo'];
  

  try {
     
    console.log("request parameter :",req);
    console.log(req.body);
   

     
    console.log("parameter id : ", id);

   
    if (id === list[0]) {
      const url = req.protocol + "://" + req.hostname +"/"+ req.file.destination;
      const  Photo = url+ req.file.originalname;
      Patient.updateOne({ _id:  (userId) }, {
        $set: {
          fullName: name,
          profileImage: Photo,
        }
      }).then((val) => { res.send("true"); console.log(val)}).catch(err => console.error(err));
    }
    else if (id === list[1]) {
      Patient.updateOne({ _id:    (userId) }, {
        $set: {
          Age: Age,
          Gender: Gender,
          DOB: DOB,
          Mothers_Name: Mothers_Name,
          Fathers_Name: Fathers_Name,
          Blood_Type: Blood_Type,
          Weight: Weight,
          Height: Height,
          Alergy: Alergy,
        }
      }).then((val) => { res.send("true"); console.log(val) }).catch(err => console.error(err));
    }
    else if (id === list[2]) {Patient.updateOne({ _id:  (userId) }, {
      $set: {
        place:Place, phone:Phone, Alt_phone:Alt_Phone ,email:Email
      }
    }).then((val) => { res.send("true"); console.log(val)}).catch(err => console.error(err));
    }
  } catch (error) {
    console.error(error);
    res.send(error)
  }
};

module.exports = {
  EditPatientProfile,
};
