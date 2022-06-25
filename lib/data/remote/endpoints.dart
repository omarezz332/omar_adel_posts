import '../../helpers/storage_keys.dart';

const kSignUp = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$fireBaseToken';
const kSignIn = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$fireBaseToken';
const signOut = 'https://identitytoolkit.googleapis.com/v1/accounts:signOut?key=$fireBaseToken';
const refreshToken = 'https://securetoken.googleapis.com/v1/token?key=$fireBaseToken';
const kPosts = 'https://omaradelposts-default-rtdb.firebaseio.com/posts.json';