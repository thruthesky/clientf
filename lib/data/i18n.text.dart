/// 대소문자 구분없이 기록
/// 나중에 모두 소문자로 변경해서 사용 함
const Map<String, Map<String, String>> textTranslations = {
  'appname': {
    'ko': '커뮤니티 앱',
    'en': 'Community App',
  },
  'app subtitle': {
    'ko': '플러터 스터도 모임 공개 프로젝트',
    'en': 'Flutter study public project',
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
};

///
void i18nTextKeyToLower() {
  for (String k in textTranslations.keys) {
    if (k != k.toLowerCase()) {
      print('ERROR ========================>');
      print('i18n key must be in lower case');
      print('$k');
    }
  }
}
