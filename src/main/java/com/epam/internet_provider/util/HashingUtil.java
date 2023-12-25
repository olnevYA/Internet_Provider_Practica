package com.epam.internet_provider.util;

import com.lambdaworks.crypto.SCryptUtil;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class HashingUtil {

  private static final int CPU_COST = 64;
  private static final int MEMORY_COST = 16;
  private static final int PARALLELIZATION = 16;
  /**
   * Encrypt original string.
   *
   * @param originalString The string to be encrypted
   * @return encrypted string.
   */
  public static String hashString(String originalString) {
    return SCryptUtil.scrypt(originalString, CPU_COST, MEMORY_COST, PARALLELIZATION);
  }
  /**
   * Check for equals originalString, and hashedString.
   *
   * @param originalString original string for checking equals
   * @param hashedString hashed string for checking equals
   * @return boolean result of checking for equals original and hashed string: true - if equals, and
   *     false - if not equals.
   */
  public static boolean checkString(String originalString, String hashedString) {
    return SCryptUtil.check(originalString, hashedString);
  }
}
