package com.epam.internet_provider.util;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.json.JSONObject;

import java.io.BufferedReader;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class JsonUtil {
  /**
   * Parse the BufferedReader object to json object.
   *
   * @param requestBuffer The BufferedReader object.
   * @return parsed JSONObject.
   */
  public static JSONObject parseData(BufferedReader requestBuffer) {
    return new JSONObject(
        requestBuffer.lines().reduce("", (accumulator, actual) -> accumulator + actual));
  }
}
