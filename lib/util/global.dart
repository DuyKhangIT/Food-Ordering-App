
import '../model/get_list_favorite/get_list_favorite_response/favorite_foods_response.dart';

class Global {
    static String orderId = "";

    /// Condition to check the email address
    bool checkEmailAddress(String newEmail) {
        if (newEmail.isNotEmpty) {
            return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(newEmail);
        }
        return false;
    }
    /// kí tự tiếng việt
    String accentParser(String text) {
        const String _vietnamese = 'aAeEoOuUiIdDyY';
        final _vietnameseRegex = <RegExp>[
            RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
            RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
            RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
            RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
            RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
            RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
            RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
            RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
            RegExp(r'ì|í|ị|ỉ|ĩ'),
            RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
            RegExp(r'đ'),
            RegExp(r'Đ'),
            RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
            RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
        ];

        String result = text;
        for (var i = 0; i < _vietnamese.length; ++i) {
            result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
        }
        return result;
    }

    /// block auto click or many time click
    static int mTimeClick = 0;

    static bool isAvailableToClick() {
        if (DateTime.now().millisecondsSinceEpoch - mTimeClick > 2000) {
            mTimeClick = DateTime.now().millisecondsSinceEpoch;
            return true;
        }
        return false;
    }
}