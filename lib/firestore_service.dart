// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Create a new repair job
//   Future<void> createRepairJob(Map<String, dynamic> data) async {
//     await _firestore.collection('RepairJob').add(data);
//   }

//   // Get all repair jobs for a specific customer
//   Stream<QuerySnapshot> getRepairJobsForCustomer(String customerId) {
//     return _firestore
//         .collection('RepairJob')
//         .where('customerId', isEqualTo: customerId)
//         .snapshots();
//   }

//   // Update the status of a repair job
//   Future<void> updateRepairJobStatus(String jobId, String newStatus) async {
//     await _firestore.collection('RepairJob').doc(jobId).update({
//       'status': newStatus,
//     });
//   }

//   // ... (add more Firestore operations as needed)
// }