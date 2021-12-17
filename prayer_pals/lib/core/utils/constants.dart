import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PrayerType {
  Answered,
  MyPrayers,
  Group,
  Global,
}

class Constants {
  static final ppcMainGradient = [
    Colors.lightBlue.shade200,
    Colors.lightBlueAccent.shade200,
  ];
}

class Globals {
  static String prayerListName = 'My Prayers'; // may not need
  static String uid = '';
  static String userName = 'User Name';
  static DateFormat formatDate = DateFormat("yMd");
  static var numberFormat = NumberFormat("###,###");
}

class PPCstuff {
  static const divider =
      Divider(height: 20, thickness: 2, indent: 20, endIndent: 20);
  static const smallTextStyle = TextStyle(
    fontFamily: 'Helvetica',
    color: Colors.black,
    fontSize: 16,
    height: 1.8,
  );
}

class ImagesURLConstants {
  static const ppcLogo = 'assets/images/PrayerPalsLogo.png';
}

class StringConstants {
//Login and Registration
  static const forgotPassword = 'Forget Password?';
  static const areYouSure = 'Are You Sure?';
  static const doYouWishToDeleteThisPrayer =
      'Delete this prayer?\nThis cannot be undone.';
  static const createAnAccountCaps = 'CREATE AN ACCOUNT';
  static const emailAddress = 'Email Address';
  static const loginCaps = 'LOGIN';
  static const newToPrayerPals = 'New To Prayer Pals?';
  static const password = 'Password';
  static const pleaseClickVerificationLinkMsg =
      'Please click the verification link in the email to activate your account.\n\nYou may then sign in.';
  static const pleaseEnterAnEmailAddress =
      'Please enter a valid email address and we will send you a reset password link';
  static const verificationEmailMsg1 = 'We have sent an email to: ';
  static const aPasswordResetEmailWasSent =
      'A password reset link was sent to your email address!';
  static const signUpCaps = 'SIGN UP';
  static const username = 'Username';
  static const register = 'Register';

//Page Titles
  static const addPrayer = 'Add Prayer';
  static const editPrayer = 'Edit Prayer';
  static const prayers = 'Prayers';
  static const answeredPrayer = 'Answered Prayer';
  static const prayNow = 'Pray Now';
  static const activity = 'Activity';
  static const connections = 'Connections';
  static const settings = 'Settings';
  static const home = 'Home';
  static const myPrayers = 'My Prayers';
  static const myGroups = 'My Groups';
  static const joinGroup = 'Join Group';
  static const startGroup = 'Start Group';
  static const admin = 'Admin';
  static const adminContacts = 'Contacts';
  static const members = 'Members';
  static const prayerPals = 'Prayer Pals';
  static const editProfile = 'Edit Profile';
  static const answered = 'Answered';

//Prayers
  static const almostThere = 'Almost There...';
  static const createPrayerErrorNoTitle = '- Please enter a title';
  static const createPrayerErrorNoDescription = '- Please enter a description';

  static const createGroupMembersErrorNoTitle = '- Please enter a title';
  static const createGroupMembersErrorNoDescription =
      '- Please enter a description';
  static const details = 'Details...';
  static const done = 'Done';
  static const edit = 'Edit';
  static const saveChanges = 'Save Changes';
  static const view = 'View';
  static const prayerTitle = 'Prayer Title';
  static const remove = 'Remove';
  static const add = 'Add';

//Collections
  static const usersCollection = 'users';
  static const myPrayersCollection = 'myPrayers';
  static const answeredPrayersCollection = 'answeredPrayers';
  static const userGroupsCollection = 'userGroups';
  static const globalPrayersCollection = 'globalPrayers';
  static const globalAnsweredCollection = 'globalAnswered';
  static const groupsCollection = 'groups';
  static const groupMemberCollection = "groupMember";
  static const groupPrayerCollection = "groupPrayers";
  static const groupAnsweredCollection = "groupAnswered";
  static const scriptureCollection = 'scriptures';

//Messages
  static const genericError = 'Generic Error';
  static const okCaps = 'OK';
  static const oops = 'Oops';
  static const success = 'Success';

//Activity
  static const memberSince = 'Member Since';
  static const AnsweredPrayers = 'Answered Prayers';
  static const PrayersRequested = 'Prayers Requested';
  static const HoursInPrayer = 'Hours in Prayer';
  static const DaysPrayedWeek = 'Days Prayed This Week';
  static const DaysPrayedMonth = 'Days Prayed This Month';
  static const DaysPrayedYear = 'Days Prayed This Year';
  static const DaysPrayedLastYear = 'Days Prayed Last Year';

// Settings Page
  static const settingsCaps = 'SETTINGS';
  static const changePassword = 'Change Password';
  static const setReminder = 'Set Daily Prayer Reminder';
  static const viewActivity = 'View Activity';
  static const notifications = 'Notifications';
  static const supportCaps = 'SUPPORT';
  static const aboutUs = 'About Us';
  static const usersGuide = "User's Guide";
  static const privacyPolicy = 'Privacy Policy';
  static const terms = 'Terms of Service';
  static const reportProblem = 'Report a Problem';
  static const sendFeedback = 'Send Feedback';
  static const removeAds = 'Remove Ads';
  static const logOutCaps = 'LOG OUT';
  static const PPCHome = 'https://prayerpalsapp.com';
  static const PPCGuide = 'https://www.prayerpalsapp.com/user-s-guide';
  static const PPCPolicy = 'https://www.prayerpalsapp.com/privacy-policy';
  static const PPCTerms = 'https://www.prayerpalsapp.com/terms-of-service';
  static const PPCSupport = 'Support@PrayerPalsApp.com';
  static const PPCInfo = 'Info@PrayerPalsApp.com';

//Buttons
  static const share = 'Share';
  static const search = 'Search';
  static const save = 'Save';
  static const cancel = 'Cancel';
  static const approve = 'Approve';
  static const join = 'Join';
  static const createGroup = 'Create Group';
  static const groupMessage = 'Send Group Message';
  static const adminMessage = 'Send Message to Admin';
  static const inviteToGroup = 'Invite Member to Group';
  static const editGroupName = 'Edit Group Name';
  static const editGroup = 'Edit Group';
  static const invite = 'Invite';
  static const createMember = 'Create Member';
  static const create = 'Create';
  static const delete = 'Delete';
  static const deleteAccount = 'Delete Account';
  static const camera = 'Camera';
  static const photos = 'Photos';
  static const resignAdmin = 'Resign Admin';
  static const assignAdmin = 'Assign Admin';
  static const removeAdmin = 'Remove Admin';
  static const report = 'Report Abuse';

//Hints
  static const keywords = 'Keyword(s)';
  static const groupName = 'Group Name';
  static const phoneNumber = 'Phone Number';

//Section Titles
  static const pendingRequests = 'Pending Requests';
  static const send = 'Send';
  static const app = 'App';
  static const text = 'Text';
  static const email = 'Email';
  static const myPrayer = 'My Prayer';
  static const group = 'group';
  static const updateProfilePicture = 'Update Profile Picture';
  static const personalNotifications = 'Personal Notifications';
  static const groupTags = 'Tags';
  static const creategroupErrorNoName = '- Please enter a name';
  static const groupDescription =
      'Enter group description here... You can place text and links to a prayer website, or online prayer meeting';
  static const ownerMessage =
      "You cannot remove the Group Owner from Admin in this screen. Only the group owner can remove Admin status from the Group Edit screen.";
}
