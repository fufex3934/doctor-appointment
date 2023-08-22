const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const multer = require("multer");
const upload = multer({ dest: "uploads/" });

//register patient
const EditDoctorProfile = async (req, res) => {
  const id = req.params.id;
  const {  Age, FullName, Specialization, Experience, Place, Phone, Alt_Phone ,Email,userId,Price,Gender } = req.body;
  const list= ['nameAndImage', 'profileInfo', 'addressInfo'];
  

    try {
        // const url = req.protocol + "://" + req.hostname +"/"+ req.file.destination;
     
    console.log("request parameter :",req);
    console.log(req.body);
   

     
    console.log("parameter id : ", id);

   
    if (id === list[0]) {
        const url = req.protocol + "://" + req.hostname +"/"+ req.files['profileImage'][0].destination;
      const  Photo = url+ req.files['profileImage'][0].originalname;
      Doctor.updateOne({ _id:  (userId) }, {
        $set: {
          fullName: FullName,
          profileImage: Photo,
        }
      }).then((val) => { res.send("true"); console.log(val)}).catch(err => console.error(err));
    }
    else if (id === list[1]) {
        const url = req.protocol + "://" + req.hostname +"/"+ req.files['licensePdf'][0].destination;
        const license = url + req.files['licensePdf'][0].originalname;
        const idImage = url + req.files['idImage'][0].originalname;
      Doctor.updateOne({ _id:    (userId) }, {
        $set: {
          age: Age,
          gender: Gender,
          price: Price,
          fullName:FullName,
          specialization: Specialization,
          Experience: Experience,
          email: Email,
         idImage: idImage,
          license:license
          
        }
      }).then((val) => { res.send("true"); console.log(val) }).catch(err => console.error(err));
    }
    else if (id === list[2]) {Doctor.updateOne({ _id:  userId }, {
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
    EditDoctorProfile,
};
