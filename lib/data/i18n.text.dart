import 'package:clientf/enginf_clientf_service/enginf.defines.dart';
import 'package:clientf/services/app.defines.dart';
import 'package:flutter/foundation.dart';

/// 대소문자 구분없이 기록
/// 나중에 모두 소문자로 변경해서 사용 함
const Map<String, Map<String, String>> textTranslations = {
  'appname': {
    'ko': '좌충우돌 플러터',
    'en': 'Flutter Beginners',
  },
  'app subtitle': {
    'ko': '플러터 스터디 모임 공개 프로젝트',
    'en': 'Flutter study public project',
  },
  'ok': {
    'ko': '확인',
    'en': 'OK',
  },
  'yes': {
    'ko': '예',
    'en': 'Yes',
  },
  'no': {
    'ko': '아니오',
    'en': 'No',
  },
  'home': {
    'ko': '홈',
    'en': 'Home',
  },
  'help': {
    'ko': '도움말',
    'en': 'Help',
  },
  'register': {
    'ko': '회원가입',
    'en': 'Register',
  },
  'profile': {
    'ko': '회원정보',
    'en': 'Profile',
  },
  'chatting': {
    'ko': '채팅',
    'en': 'Chatting',
  },
  'setting': {
    'ko': '설정',
    'en': 'Settings',
  },
  'photo': {
    'ko': '사진',
    'en': 'Photo',
  },
  'read more': {
    'ko': '자세히',
    'en': 'Read more',
  },
  'next': {
    'ko': '다음',
    'en': 'Next',
  },
  'loading': {
    'ko': '로딩 중입니다.',
    'en': 'Loading...',
  },
  'input email': {
    'ko': '이메일 주소를 입력 해 주세요.',
    'en': 'Please input email address.',
  },
  'input password': {
    'ko': '비밀번호를 입력 해 주세요.',
    'en': 'Please input password.',
  },
  'input nickname': {
    'ko': '닉네임을 입력해주세요.',
    'en': 'Please input nickname.',
  },
  'input phone number': {
    'ko': '전화번호를 입력 해 주세요.',
    'en': 'Please input phone number.',
  },
  'input birthday': {
    'ko': '생년월일을 선택 해 주세요.',
    'en': 'Please input birday.',
  },
  'register submit': {
    'ko': '회원 등록',
    'en': 'Register',
  },
  'profile submit': {
    'ko': '회원 정보 수정',
    'en': 'Update Profile',
  },
  'login': {
    'ko': '로그인',
    'en': 'Login',
  },
  'login page title': {
    'ko': '로그인',
    'en': 'Login',
  },
  'login submit': {
    'ko': '로그인',
    'en': 'Login',
  },
  'logout': {
    'ko': '로그아웃',
    'en': 'Logout',
  },
  'post deleted': {
    'ko': '글이 삭제되었습니다.',
    'en': 'Post has been deleted!',
  },
  'discussion': {
    'ko': '자유토론',
    'en': 'Discussion',
  },
  'qna': {
    'ko': '질문과답변',
    'en': 'QnA',
  },
  'news': {
    'ko': '새소식',
    'en': 'News',
  },
  NO_TITLE: {
    'ko': '제목이 없습니다.',
    'en': 'This post have no title.',
  },
  POST_TITLE_DELETED: {
    'ko': '삭제되었습니다.',
    'en': 'This post is deleted.',
  },
  ERROR_INVALID_EMAIL: {
    'ko': '이메일 주소 형식 오류\n올바른 이메일 주소를 입력 해 주세요.',
    'en': 'The email address is badly formatted.\nPleae input correct email.',
  },
  ERROR_USER_NOT_FOUND: {
    'ko': '이메일에 대한 회원 정보를 찾지 못했습니다. 회원 가입을 하지 않았거나 탈퇴하였습니다.',
    'en': 'No user found by that email. Or the user may have been resigned.',
  },
  ERROR_WRONG_PASSWORD: {
    'ko': '비밀번호가 올바르지 않습니다.',
    'en': 'The password is invalid or the user does not have a password.',
  },
  AUTH_INVALID_PHONE_NUMBER: {
    'ko': '전화번호가 올바르지 않습니다. 올바른 전화번호를 입력 해 주세요.',
    'en': 'Invalid phone number. Please input correct phone number.',
  },
  INPUT_EMAIL: {
    'ko': '이메일 주소를 입력 해 주세요.',
    'en': 'Please input email address.',
  },
  INPUT_PASSWORD: {
    'ko': '비밀번호를 입력 해 주세요.',
    'en': 'Please input password.',
  },
  AUTH_INVALID_EMAIL: {
    'ko': '이메일 주소 형식이 올바르지 않습니다.',
    'en': 'Email address is not incorrect.',
  },
  AUTH_INVALID_PASSWORD: {
    'ko': '비밀번호가 올바르지 않습니다.',
    'en': 'The password is invalid.',
  },
  LOGIN_FIRST: {
    'ko': '로그인을 해 주세요.',
    'en': 'Please, login first!',
  },
  AUTH_USER_NOT_FOUND: {
    'ko': '가입된 회원 정보를 찾을 수 없습니다.',
    'en': 'User not found.',
  },
  USER_NOT_EXIST: {
    'ko': '회원 정보 DB 에서 찾을 수 없습니다.',
    'en': 'User not found in Database.',
  },
  AUTH_PHONE_NUMBER_ALREADY_EXIST: {
    'ko': '전화 번호가 다른 회원에 의해서 등록되어져 있습니다.',
    'en': 'The phone number is already registered by other user',
  },
  ALREADY_LOGIN_ON_REGISTER_PAGE: {
    'ko': '앗! 이미 로그인을 하였습니다.\n로그인을 한 상태에서는 회원 가입 페이지를 열 수 없습니다.',
    'en':
        'Ooh! You have already logged in.\nYou cannot open register page while you are logged in.',
  },
};


/// i18n 문자열 키 소문자 확인
/// 
/// i18n 문자열의 키는 반드시 소문자열 이어야한다.
void i18nTextKeyToLower() {
  if (kDebugMode) {
    for (String k in textTranslations.keys) {
      assert(k == k.toLowerCase(), 'i18n key [$k] must be in lower case');
    }
  }
}
