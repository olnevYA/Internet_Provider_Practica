package com.epam.internet_provider.util;

import com.epam.internet_provider.model.Role;
import com.epam.internet_provider.model.Status;
import com.epam.internet_provider.model.User;
import com.epam.internet_provider.service.DecryptionService;
import com.epam.internet_provider.service.impl.DecryptionServiceImpl;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.json.JSONObject;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class UserUtil {

  private static final Role DEFAULT_ROLE = Role.User;
  private static final Status DEFAULT_STATUS = Status.New;
  private static final int DEFAULT_AMOUNT = 0;
  private static final int DEFAULT_CASH = 0;
  private static DecryptionService decryptionService = new DecryptionServiceImpl();

  /**
   * Reads the json object with user data, and returns initialized User object.
   *
   * @param userJson The json with user data.
   * @return initialized object of User.class
   */
  public static User createDefaultUser(JSONObject userJson) {
    final User user = new User();
    user.setLogin(userJson.getString("login"));
    user.setPassword(
        HashingUtil.hashString(decryptionService.decryptString(userJson.getString("password"))));
    user.setEmail(userJson.getString("email"));
    user.setRole(DEFAULT_ROLE);
    user.setStatus(DEFAULT_STATUS);
    user.setBonusAmount(DEFAULT_AMOUNT);
    user.setCash(DEFAULT_CASH);
    return user;
  }
}
