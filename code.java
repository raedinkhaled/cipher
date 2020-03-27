public static String encrypt(String plainText, int shift) {
    if (shift < 0) {
      shift += 26;
    }

    String encryptedText = "";

    for (int i = 0; i < plainText.length(); i++) {
      char c = plainText.charAt(i);
      if (Character.isLetter(c)) {
        int code = c;
        // en cas ou le caractere est Majiscule
        if ((code >= 65) && (code <= 90)) {
          c = (char)(((code - 65 + shift) % 26) + 65);
          
        }
        // Caractere Miniscule
        else if ((code >= 97) && (code <= 122)) {
          c = (char)(((code - 97 + shift) % 26) + 97);
        }
      }

      encryptedText += c;
    }

    return encryptedText;
  }

    public static String decrypt(String cryptedText, int shift) {
    if (shift < 0) {
      shift += 26;
    }

    String decryptedText = "";

    for (int i = 0; i < cryptedText.length(); i++) {
      char c = cryptedText.charAt(i);
      if (Character.isLetter(c)) {
        int code = c;
        // en cas ou le caractere est Majiscule
        if ((code >= 65) && (code <= 90)) {
          int newShift= code - 65 - shift;
          if (newShift < 0) {
      			newShift += 26;
    		}
          c = (char)(((newShift) % 26) + 65);
          
        }
        // Caractere Miniscule
        else if ((code >= 97) && (code <= 122)) {
          int newShift= code - 97 - shift;
          if (newShift < 0) {
      			newShift += 26;
    		}
          c = (char)(((newShift) % 26) + 97);
        }
      }

      decryptedText += c;
    }

    return decryptedText;
  }
