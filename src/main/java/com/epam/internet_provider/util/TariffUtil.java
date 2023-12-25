package com.epam.internet_provider.util;

import com.epam.internet_provider.model.Tariff;
import io.vavr.control.Try;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.json.JSONObject;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class TariffUtil {
  /**
   * Reads the json object with tariff data, and returns initialized Tariff object.
   *
   * @param tariffJson The json with tariff data.
   * @return initialized object of Tariff.class
   */
  public static Tariff createTariff(JSONObject tariffJson) {
    final Tariff tariff = new Tariff();
    tariff.setId(Try.of(() -> tariffJson.getInt("id")).getOrElse(0));
    tariff.setTitle(tariffJson.getString("title"));
    tariff.setDownloadSpeed(tariffJson.getInt("downloadSpeed"));
    tariff.setUploadSpeed(tariffJson.getInt("uploadSpeed"));
    tariff.setCost(tariffJson.getInt("cost"));
    tariff.setTraffic(tariffJson.getInt("traffic"));
    tariff.setImgUrl(tariffJson.getString("imgUrl"));
    return tariff;
  }
}
