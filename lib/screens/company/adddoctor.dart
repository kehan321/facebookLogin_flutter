import 'package:cloud_firestore/cloud_firestore.dart';

void addDoctorsData() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Expanded list of doctors data
  List<Map<String, dynamic>> doctorsData = [
    {
      "name": "Dr. John Smith",
      "occupation": "Cardiologist",
      "imageUrl": "https://images.unsplash.com/photo-1638202993928-7267aad84c31?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZG9jdG9yfGVufDB8fDB8fHww",
      "about": "Heart disease expert with 20 years of experience.",
      "ratings": 4.8,
      "location": "New York, NY",
      "consultationPrice": 150,
      "symptoms": ["Fever", "Shortness of Breath"]
    },
    {
      "name": "Dr. Jane Doe",
      "occupation": "Dermatologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1661764878654-3d0fc2eefcca?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9jdG9yfGVufDB8fDB8fHww",
      "about": "Specializes in skin conditions and cosmetic procedures.",
      "ratings": 4.9,
      "location": "Los Angeles, CA",
      "consultationPrice": 120,
      "symptoms": ["Headache", "Fatigue"]
    },
    {
      "name": "Dr. Emily Johnson",
      "occupation": "Neurologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1681996484614-6afde0d53071?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fGRvY3RvcnxlbnwwfHwwfHx8MA%3D%3D",
      "about": "Focuses on brain and spinal cord disorders.",
      "ratings": 4.7,
      "location": "Chicago, IL",
      "consultationPrice": 200,
      "symptoms": ["Headache", "Fatigue"]
    },
    {
      "name": "Dr. Michael Brown",
      "occupation": "Pediatrician",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1661766718556-13c2efac1388?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGRvY3RvcnxlbnwwfHwwfHx8MA%3D%3D",
      "about": "Comprehensive care for children and adolescents.",
      "ratings": 4.6,
      "location": "Houston, TX",
      "consultationPrice": 90,
      "symptoms": ["Fever", "Cough"]
    },
    {
      "name": "Dr. Sarah Wilson",
      "occupation": "Orthopedic Surgeon",
      "imageUrl": "https://media.istockphoto.com/id/1944704622/photo/successful-doctor-woman-standing-outside-at-front-of-medical-clinic-looking-at-camera.webp?a=1&b=1&s=612x612&w=0&k=20&c=hY1ZEPx9RdzYpmlJ-lRzm9isyS-fUvyx168pNPJm3Dc=",
      "about": "Specializes in bone and joint surgeries.",
      "ratings": 4.8,
      "location": "Philadelphia, PA",
      "consultationPrice": 180,
      "symptoms": ["Fatigue", "Headache"]
    },
    {
      "name": "Dr. David Martinez",
      "occupation": "Oncologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1702598773834-be6d566bb57f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9jdG9yJTIwcHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
      "about": "Expert in cancer treatment and research.",
      "ratings": 4.5,
      "location": "Phoenix, AZ",
      "consultationPrice": 220,
      "symptoms": ["Fatigue", "Headache"]
    },
    {
      "name": "Dr. Laura Garcia",
      "occupation": "Gynecologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1661745996675-24e3fead19c4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9jdG9yJTIwcHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
      "about": "Women's reproductive health and prenatal care.",
      "ratings": 4.7,
      "location": "San Antonio, TX",
      "consultationPrice": 130,
      "symptoms": ["Fever", "Shortness of Breath"]
    },
    {
      "name": "Dr. William Anderson",
      "occupation": "ENT Specialist",
      "imageUrl": "https://images.unsplash.com/photo-1651008376811-b90baee60c1f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGRvY3RvciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D",
      "about": "Expert in ear, nose, and throat disorders.",
      "ratings": 4.6,
      "location": "San Diego, CA",
      "consultationPrice": 110,
      "symptoms": ["Cough", "Shortness of Breath"]
    },
    {
      "name": "Dr. Jessica Lee",
      "occupation": "Internal Medicine Specialist",
      "imageUrl": "https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGRvY3RvciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D",
      "about": "Comprehensive care for internal conditions.",
      "ratings": 4.9,
      "location": "Dallas, TX",
      "consultationPrice": 140,
      "symptoms": ["Fever", "Headache"]
    },
    {
      "name": "Dr. Robert Young",
      "occupation": "Endocrinologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1661745981779-0453d5f66531?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZG9jdG9yJTIwcHJvZmlsZSUyMGZyb250JTIwc2RlfGVufDB8fDB8fHww",
      "about": "Specializes in hormone-related disorders.",
      "ratings": 4.8,
      "location": "San Jose, CA",
      "consultationPrice": 160,
      "symptoms": ["Fatigue", "Shortness of Breath"]
    },
    {
      "name": "Dr. Nancy Harris",
      "occupation": "Rheumatologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1664475543697-229156438e1e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGRvY3RvciUyMHByb2ZpbGUlMjBmcm9udCUyMHNkZXxlbnwwfHwwfHx8MA%3D%3D",
      "about": "Expert in autoimmune and joint diseases.",
      "ratings": 4.7,
      "location": "Austin, TX",
      "consultationPrice": 170,
      "symptoms": ["Headache", "Fatigue"]
    },
    {
      "name": "Dr. James Clark",
      "occupation": "Psychiatrist",
      "imageUrl": "https://media.istockphoto.com/id/1494324708/photo/portrait-of-asian-chinese-mixed-race-senior-mature-man-doctor-in-collared-business-shirt.webp?a=1&b=1&s=612x612&w=0&k=20&c=RZlTllWuF5w0FkZuWpkL_i0PbglkI6IjqetC2ezJgME=",
      "about": "Mental health assessments and treatment.",
      "ratings": 4.6,
      "location": "Jacksonville, FL",
      "consultationPrice": 150,
      "symptoms": ["Fatigue", "Headache"]
    },
    {
      "name": "Dr. Karen Lewis",
      "occupation": "Pathologist",
      "imageUrl": "https://media.istockphoto.com/id/489339032/photo/your-health-is-what-i-work-for.webp?a=1&b=1&s=612x612&w=0&k=20&c=lJOw70u8HLFjp2Zmnf8va4UPY79oaRvjP8fwqH-rRts=",
      "about": "Diagnoses diseases through lab tests.",
      "ratings": 4.5,
      "location": "San Francisco, CA",
      "consultationPrice": 140,
      "symptoms": ["Cough", "Shortness of Breath"]
    },
    {
      "name": "Dr. Brian Walker",
      "occupation": "Urologist",
      "imageUrl": "https://media.istockphoto.com/id/1486172842/photo/portrait-of-male-nurse-in-his-office.webp?a=1&b=1&s=612x612&w=0&k=20&c=EE0DSIQPGhtJHAoHMg2Zhg8LhAAWOG3aFTkho9r_MNc=",
      "about": "Specializes in urinary tract and male reproductive issues.",
      "ratings": 4.8,
      "location": "Columbus, OH",
      "consultationPrice": 160,
      "symptoms": ["Fever", "Fatigue"]
    },
    {
      "name": "Dr. Megan Hall",
      "occupation": "Ophthalmologist",
      "imageUrl": "https://media.istockphoto.com/id/1488346850/photo/portrait-of-doctor-thinking.webp?a=1&b=1&s=612x612&w=0&k=20&c=GQeZ-kOuhQVFFAOn-ccJJOlcFtrckn2rhMSgOnZI5MY=",
      "about": "Expert in eye care and vision correction.",
      "ratings": 4.7,
      "location": "Indianapolis, IN",
      "consultationPrice": 130,
      "symptoms": ["Headache", "Shortness of Breath"]
    },
    {
      "name": "Dr. Joshua Allen",
      "occupation": "Gastroenterologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1661578535048-7a30e3a71d25?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9jdG9yJTIwcHJvZmlsZSUyMGZyb250JTIwc2RlfGVufDB8fDB8fHww",
      "about": "Care for digestive system disorders.",
      "ratings": 4.9,
      "location": "Charlotte, NC",
      "consultationPrice": 190,
      "symptoms": ["Fatigue", "Headache"]
    },
    {
      "name": "Dr. Lisa King",
      "occupation": "Pulmonologist",
      "imageUrl": "https://media.istockphoto.com/id/1445626516/photo/young-latin-doctor-with-beard-wearing-white-coat-photographed-in-studio-against-white.webp?a=1&b=1&s=612x612&w=0&k=20&c=uKbKPxNPdB2p5tMGEzyIDNw51FvfIRNdayI0Fh75bcU=",
      "about": "Specializes in lung diseases and respiratory issues.",
      "ratings": 4.6,
      "location": "San Francisco, CA",
      "consultationPrice": 180,
      "symptoms": ["Shortness of Breath", "Cough"]
    },
    {
      "name": "Dr. Daniel Wright",
      "occupation": "Hematologist",
      "imageUrl": "https://media.istockphoto.com/id/107429774/photo/doctor-thinking-in-doctors-office.webp?a=1&b=1&s=612x612&w=0&k=20&c=FzGJOGu0CXi6-DAbDii18JeACUVIaez31lG3RLG8Qk0=",
      "about": "Expert in blood disorders and diseases.",
      "ratings": 4.8,
      "location": "Seattle, WA",
      "consultationPrice": 210,
      "symptoms": ["Fatigue", "Headache"]
    },
    {
      "name": "Dr. Michelle Thompson",
      "occupation": "Nephrologist",
      "imageUrl": "https://media.istockphoto.com/id/1364917577/photo/handsome-doctor-smiling-and-standing-on-white-background.webp?a=1&b=1&s=612x612&w=0&k=20&c=0F8FRwsViBoF5-P-TUeAFXvaBYFh6VPXvuYmKlI0_ac=",
      "about": "Specializes in kidney health and diseases.",
      "ratings": 4.7,
      "location": "Denver, CO",
      "consultationPrice": 200,
      "symptoms": ["Fatigue", "Shortness of Breath"]
    },
    {
      "name": "Dr. Andrew Scott",
      "occupation": "Surgeon",
      "imageUrl": "https://media.istockphoto.com/id/1467252717/photo/portrait-of-a-confident-female-doctor-standing-against-brown-wall.webp?a=1&b=1&s=612x612&w=0&k=20&c=h-59Zm7P1cN0W6NIQ8ONpTQ-QA51hv2LeK0BjXVGlW0=",
      "about": "Experienced in various surgical procedures.",
      "ratings": 4.9,
      "location": "Washington, DC",
      "consultationPrice": 250,
      "symptoms": ["Fever", "Fatigue"]
    },
    {
      "name": "Dr. Olivia Evans",
      "occupation": "Endocrinologist",
      "imageUrl": "https://media.istockphoto.com/id/837226484/photo/with-her-good-health-is-in-sight.webp?a=1&b=1&s=612x612&w=0&k=20&c=Twbyk67aMERMKigzVwuMoK_jH9kwXS6yyYKQ88jr4zQ=",
      "about": "Specializes in diabetes and thyroid disorders.",
      "ratings": 4.8,
      "location": "Boston, MA",
      "consultationPrice": 175,
      "symptoms": ["Fatigue", "Headache"]
    },
    {
      "name": "Dr. Ethan Turner",
      "occupation": "Pulmonologist",
      "imageUrl": "https://images.unsplash.com/photo-1524499982521-1ffd58dd89ea?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGRvY3RvciUyMHByb2ZpbGUlMjBmcm9udHxlbnwwfHwwfHx8MA%3D%3D",
      "about": "Expert in chronic respiratory conditions.",
      "ratings": 4.7,
      "location": "San Jose, CA",
      "consultationPrice": 160,
      "symptoms": ["Shortness of Breath", "Cough"]
    },
    {
      "name": "Dr. Sophia Adams",
      "occupation": "Rheumatologist",
      "imageUrl": "https://media.istockphoto.com/id/1425798958/photo/photo-of-confident-female-doctor-in-hospital-looking-at-camera-with-smile.webp?a=1&b=1&s=612x612&w=0&k=20&c=2L3P5AC7hLyPdqo_8A5NybN_5QgsUNd49hzR2dYn5hQ=",
      "about": "Specializes in arthritis and autoimmune diseases.",
      "ratings": 4.9,
      "location": "Nashville, TN",
      "consultationPrice": 190,
      "symptoms": ["Headache", "Fatigue"]
    },
    {
      "name": "Dr. Noah Harris",
      "occupation": "Cardiologist",
      "imageUrl": "https://media.istockphoto.com/id/1691072014/photo/close-up-portrait-of-young-indian-doctor-man-in-white-medical-coat-serious-and-thinking.webp?a=1&b=1&s=612x612&w=0&k=20&c=kyze5wqyW8m0HI4gkmvse7usvuQqLV8RmEw7QGzPxOQ=",
      "about": "Expert in heart diseases and hypertension.",
      "ratings": 4.8,
      "location": "Minneapolis, MN",
      "consultationPrice": 170,
      "symptoms": ["Shortness of Breath", "Fatigue"]
    },
    {
      "name": "Dr. Mia Roberts",
      "occupation": "Dermatologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1661341423936-40b48564a5bf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9jdG9yJTIwcHJvZmlsZSUyMGltYWdlfGVufDB8fDB8fHww",
      "about": "Specializes in treating skin conditions and cosmetic issues.",
      "ratings": 4.7,
      "location": "Cleveland, OH",
      "consultationPrice": 140,
      "symptoms": ["Headache", "Shortness of Breath"]
    },
  ];

  List<String> documentIds = []; // List to store document IDs

  for (var doctor in doctorsData) {
    var docRef = await firestore.collection('doctors').add(doctor);
    documentIds.add(docRef.id); // Store the document ID
  }

  print('Doctors data added successfully');
  print('Document IDs: $documentIds');
}
