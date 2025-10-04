# 📸 Image Slider Presentation App

Görsellerinizi profesyonel sunumlara dönüştürün! Flutter ile geliştirilmiş, kullanıcı dostu bir sunum oluşturma uygulaması.

## ✨ Özellikler

- 🖼️ **Çoklu Resim Seçimi**: Galeriden istediğiniz kadar resim seçin
- ⏱️ **Özelleştirilebilir Geçiş Süreleri**: Her slayt için ayrı ayrı süre ayarlayın (1-10 saniye)
- 🎨 **Animasyon Efektleri**: Fade, Slide ve Zoom geçiş animasyonları
- 🔀 **Karıştırma Modu**: Slaytları rastgele sıraya koyun
- ↕️ **Sürükle-Bırak Sıralama**: Slaytları kolayca yeniden düzenleyin
- ⏲️ **Çalışma Zamanlayıcısı**: Belirli bir süre sonra otomatik çıkış
- 💾 **Kaydetme Fonksiyonu**: Sunumlarınızı saklayın
- 🎯 **Tam Ekran Mod**: Çift tıklama ile ana menüye dönüş
- 🌓 **Dark Theme**: Göz dostu karanlık tema

## 🚀 Kurulum

### Gereksinimler

- Flutter SDK (3.6.0 veya üzeri)
- Dart SDK
- Android Studio / VS Code
- iOS için: Xcode (macOS)
- Android için: Android SDK

### Adımlar

1. Repository'yi klonlayın:
```bash
git clone https://github.com/kullaniciadi/flutter-image-slider-app.git
cd flutter-image-slider-app
```

2. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

3. Uygulamayı çalıştırın:
```bash
flutter run
```

## 📦 Kullanılan Paketler

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^0.8.5+3  # Galeri ve kamera erişimi
  fluttertoast: ^8.0.9    # Bildirim mesajları
  cupertino_icons: ^1.0.8 # iOS stil ikonlar
```

## 🎮 Kullanım

### Sunum Oluşturma

1. Ana ekranda "Proceed to create a presentation" butonuna tıklayın
2. "Resim Seçin" butonu ile galeriden resimlerinizi seçin
3. Her slayt için:
   - ⏱️ Süre ayarlamak için zamanlayıcı ikonuna tıklayın
   - 🎨 Animasyon seçmek için animasyon ikonuna tıklayın
   - 🗑️ Silmek için çöp kutusu ikonuna tıklayın

### Slayt Yönetimi

- **Sıralama**: Slaytları yukarı-aşağı sürükleyerek yeniden düzenleyin
- **Karıştırma**: Shuffle ikonu ile rastgele sıralama
- **Kaydetme**: Save ikonu ile sunumu kaydedin
- **Temizleme**: Clear ikonu ile tüm slaytları silin

### Sunum Başlatma

1. "Start" butonuna tıklayarak sunumu başlatın
2. Her slayt belirlediğiniz süre boyunca gösterilir
3. "Stop" butonu ile sunumu durdurun
4. Çift tıklama ile ana menüye dönün

### Çalışma Zamanlayıcısı

1. "Çalışma Süresi (saniye)" alanına süre girin
2. "Çalışma Süresini Başlat" butonuna tıklayın
3. Belirlenen süre sonunda otomatik olarak ana menüye dönersiniz

## 🛠️ Proje Yapısı

```
lib/
├── main.dart           # Ana uygulama ve giriş noktası
│   ├── MyApp           # MaterialApp widget'ı
│   ├── MainScreen      # Ana menü ekranı
│   └── ImageSliderScreen # Sunum editörü ve oynatıcı
```

## 🎯 Özellik Detayları

### Animasyon Türleri

- **Fade**: Yumuşak soldurma efekti
- **Slide**: Kaydırma geçişi
- **Zoom**: Yakınlaştırma efekti

### Slayt Süreleri

- Minimum: 1 saniye
- Maximum: 10 saniye
- Varsayılan: 2 saniye

## 📱 Platform Desteği

- ✅ Android
- ✅ iOS
- ✅ Web (kısıtlı)
- ✅ Desktop (Windows, macOS, Linux)

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/YeniOzellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/YeniOzellik`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## 👨‍💻 Geliştirici

Sorularınız veya önerileriniz için issue açabilirsiniz!

## 🔮 Gelecek Özellikler

- [ ] Video desteği
- [ ] Müzik ekleme
- [ ] Bulut senkronizasyonu
- [ ] Daha fazla animasyon efekti
- [ ] Export to PDF/Video
- [ ] Tema özelleştirme

---

⭐ Projeyi beğendiyseniz yıldız vermeyi unutmayın!