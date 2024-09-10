import 'package:cloud_firestore/cloud_firestore.dart';

void addDoctorsData() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Expanded list of doctors data with unique ids
  List<Map<String, dynamic>> doctorsData = [
    {
      "id": "1",
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
      "id": "2",
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
      "id": "3",
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
      "id": "4",
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
      "id": "5",
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
      "id": "6",
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
      "id": "7",
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
      "id": "8",
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
      "id": "9",
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
      "id": "10",
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
      "id": "11",
      "name": "Dr. Nancy Harris",
      "occupation": "Rheumatologist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1664475543697-229156438e1e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGRvY3RvciUyMHByb2ZpbGV8ZW58MHx8MHx8MA%3D%3D",
      "about": "Expert in autoimmune and inflammatory diseases.",
      "ratings": 4.7,
      "location": "San Francisco, CA",
      "consultationPrice": 170,
      "symptoms": ["Fatigue", "Shortness of Breath"]
    },
    {
      "id": "12",
      "name": "Dr. Mark Wilson",
      "occupation": "Psychiatrist",
      "imageUrl": "https://plus.unsplash.com/premium_photo-1665482951775-256a1a772f2e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGRvY3RvciUyMHByb2ZpbGV8ZW58MHx8MHx8MA%3D%3D",
      "about": "Specializes in mental health and psychiatric disorders.",
      "ratings": 4.6,
      "location": "Seattle, WA",
      "consultationPrice": 190,
      "symptoms": ["Headache", "Fatigue"]
    }
  ];

  // Save the data to Firestore
  for (var doctor in doctorsData) {
    await firestore.collection('doctors').doc(doctor['id']).set(doctor);
  }

  print('Doctors data added successfully!');
}
