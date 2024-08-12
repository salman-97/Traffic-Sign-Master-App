// ignore_for_file: deprecated_member_use, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Controllers/no_internet.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_auth.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_model.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:get/get.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

/* ----------- Check Email Existence Before SIGN-UP ----------- */
  Future<bool> emailExist(String email) async {
    final querySnapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;
  }

/* ----------- Check MOBILE Existence Before SIGN-UP ----------- */
  Future<bool> mobileExist(String mobile) async {
    final querySnapshot =
        await _db.collection("Users").where("Mobile", isEqualTo: mobile).get();
    return querySnapshot.docs.isNotEmpty;
  }

/* ----------- SAVING USER DATA IN FIRESTORE ----------- */
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } catch (e) {
      throw 'Error Occured Saving User Data';
    }
  }

/* ----------- FETCHING USER DATA FROM FIRESTORE ----------- */
  Future<UserModel> fetchUserDetails() async {
    try {
      await InternetConnectivity.checkInternet();

      final documentSnapshot = await _db
          .collection("Users")
          .doc(UserAuthentication.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on NoNetwork catch (_) {
      CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'ALERT! No Internet Connection. Please check your network.');
      throw const NoNetwork();
    } catch (e) {
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: 'Something Went Wrong in fetchUserDetails method - UserRepo',
      );
      throw 'Fetch-User-Details Method Error - UserRepo: $e';
    }
  }

/* ----------- UPDATING USER DATA IN FIRESTORE ----------- */
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } catch (e) {
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: 'Something Went Wrong in updateUserDetails method - UserRepo',
      );
      throw 'Update-User-Details Error: $e';
    }
  }

/* ----------- UPDATING USER EMAIL IN AUTHENTICATION ----------- */
  Future<void> updateUserEmail(String newEmail) async {
    try {
      await UserAuthentication.instance.authUser?.updateEmail(newEmail);
    } catch (e) {
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: 'Error Updating User Email Address',
      );
      throw 'Failed to update User-Email';
    }
  }

/* ----------- UPDATING USER PASSWORD IN AUTHENTICATION ----------- */
  Future<void> updateUserPassword(
      String userEmail, String userPassword, String newPassword) async {
    try {
      User? user = UserAuthentication.instance.authUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: userEmail, password: userPassword);

        await user.reauthenticateWithCredential(credential);
        await UserAuthentication.instance.authUser?.updatePassword(newPassword);
      } else {
        throw 'USER IS NOT LOGGED IN';
      }
    } catch (e) {
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: 'Error Updating User Password',
      );
      throw 'Failed to update User-Password: $e';
    }
  }

/* ----------- CHECK EMAIL EXISTENCE BEFORE UPDATING ----------- */
  Future<bool> emailExistExceptCurrentUser(
      String newEmail, String currentEmail) async {
    final queryDB = await _db
        .collection("Users")
        .where("Email", isEqualTo: newEmail)
        .where("Email", isNotEqualTo: currentEmail)
        .get();
    return queryDB.docs.isNotEmpty;
  }

/* ----------- CHECK MOBILE EXISTENCE BEFORE  UPDATING ----------- */
  Future<bool> mobileExistExceptCurrentUser(
      String newMobile, String currentMobile) async {
    final queryDB = await _db
        .collection("Users")
        .where("Mobile", isEqualTo: newMobile)
        .where("Mobile", isNotEqualTo: currentMobile)
        .get();
    return queryDB.docs.isNotEmpty;
  }

/* ----------- SAVING USER RATING IN FIRESTORE  ----------- */
  Future<void> storeUserRating(int rating, String selectedChipText) async {
    try {
      final UserModel currentUser = await fetchUserDetails();
      if (currentUser.id != null) {
        CollectionReference userRatings = _db.collection("UserRatings");
        await userRatings.doc(currentUser.id).set({
          'Rating By': currentUser.fullname,
          'Rating Stars': rating,
          'Rating': selectedChipText,
        });
      } else {
        throw "User Not Logged In";
      }
    } catch (e) {
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: "Error Storing User Rating",
      );
      throw "Error in storeUserRating Method";
    }
  }

/* ----------- SAVING USER FEEDBACK IN FIRESTORE  ----------- */
  Future<void> storeUserFeedback(String name, email, msg) async {
    try {
      final UserModel currentUser = await fetchUserDetails();
      if (currentUser.id != null) {
        CollectionReference userFeedback = _db.collection("User Feedback");
        await userFeedback.doc(currentUser.id).set({
          'User Name': name,
          'User Email': email,
          'User Message': msg,
        });
      } else {
        throw 'User Not Logged In';
      }
    } catch (e) {
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: "Error Sharing Feedback",
      );
      throw "Error is storeUserFeedback Method";
    }
  }

/* ----------- CHECK MOBILE EXISTENCE BEFORE  UPDATING ----------- */
  Future<bool> checkMobileExistInDB(String mobileNumber) async {
    final queryDB = await _db
        .collection("Users")
        .where("Mobile", isEqualTo: mobileNumber)
        .get();
    return queryDB.docs.isNotEmpty;
  }

/* ----------- GETTING USERNAME AT RESET PASSWORD FOR MOBILE NUMBER ----------- */
  Future<Map<String, String>> userNameForMobile(String mobileNumber) async {
    try {
      final query = await _db
          .collection("Users")
          .where("Mobile", isEqualTo: mobileNumber)
          .get();
      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        final name = data['FullName'] ?? 'User';
        final email = data['Email'] ?? 'User';
        final pass = data['Password'] ?? 'User';

        // LOGGING IN USER WITH DATA FETCHED FROM FIREBASE TO INITIATE PASSWORD RESET
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);
        print('User Logged In');
        return {'name': name, 'email': email, 'password': pass};
      } else {
        return {
          'name': 'No Name Found',
          'email': 'No Email Found',
          'password': 'No Password Found'
        };
      }
    } catch (e) {
      throw 'Error fetching UserName in userNameForMobile method in UserRepo: $e';
    }
  }

/* ----------- RESET USER PASSWORD  ----------- */
  Future<void> resetUserPassword(String mobileNumber, String userEmail,
      String oldPassword, String newPassword) async {
    try {
      final changePassQuery = await _db
          .collection("Users")
          .where("Mobile", isEqualTo: mobileNumber)
          .get();
      if (changePassQuery.docs.isNotEmpty) {
        final userID = changePassQuery.docs.first.id;

        // UPDATING PASSWORD IN FIRESTORE
        await _db
            .collection("Users")
            .doc(userID)
            .update({'Password': newPassword});
        /* 
        UPDATING PASSWORD IN FIREBASE AUTHTENTICATION THE TRICK IS WITH USER MOBILE NUMBER I QUERY FIRESTORE
        TO LOOK FOR USER IF USER EXIST THEN NAVIGATE TO PASSWORD CHANGE SCREEN AND FETCH USERNAME, USEREMAIL,
        USERPASSWORD FROM FIRESTORE USING userNameForMobile FUNCTION ABOVE. HERE THE USER IS NOT LOGGED IN SO
        WITH USER DETAILS FETCHED I REAUTHENTICATED THE USER AND SIMPLY UPDATE USER PASSWORD.
        */
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(
              email: userEmail, password: oldPassword);
          await user.reauthenticateWithCredential(credential);
          updateUserPassword(userEmail, oldPassword, newPassword);
        } else {
          print('User is NULL');
          print('User Old Password: $oldPassword');
          throw 'CANNOT UPDATE PASSWORD IN FIREBASE';
        }
      } else {
        throw 'No User for Mobile $mobileNumber';
      }
    } catch (e) {
      throw 'Error Changing User Password in resetUserPassword method in UserRepo';
    }
  }
}
