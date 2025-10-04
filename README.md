# 📸 Image Slider Presentation App

**Öğrenci:** Mehmet DOĞAN  
**Proje:** Flutter ile Dinamik Sunum Uygulaması

---

## 🎬 Demo Video

https://github.com/user-attachments/assets/6e0a6560-4bea-422a-9c64-65af67e21feb

> Uygulamanın tüm özelliklerini gösteren demo videosu

---
## 📝 Proje Hakkında

Bu proje, Flutter framework'ü kullanılarak geliştirilmiş interaktif bir görsel sunum uygulamasıdır. Kullanıcılar kendi resimlerini seçerek, özelleştirilebilir geçiş efektleri ve sürelerle profesyonel sunumlar oluşturabilirler.

## ✨ Özellikler

### Temel Özellikler
- 🖼️ **Çoklu Resim Seçimi**: Galeriden istediğiniz kadar resim seçin
- ⏱️ **Özelleştirilebilir Geçiş Süreleri**: Her slayt için 1-10 saniye arası süre ayarlayın
- 🎨 **Animasyon Efektleri**: 
  - Fade (Soldurma)
  - Slide (Kaydırma)
  - Zoom (Yakınlaştırma)
- 🔀 **Karıştırma Modu**: Slaytları rastgele sıraya koyun
- ↕️ **Sürükle-Bırak Sıralama**: `ReorderableListView` ile slaytları kolayca yeniden düzenleyin

### Gelişmiş Özellikler
- ⏲️ **Çalışma Zamanlayıcısı**: Belirli bir süre sonra otomatik çıkış
- 💾 **Kaydetme Fonksiyonu**: Sunumlarınızı saklayın
- 🎯 **Tam Ekran Sunum Modu**: Dikkat dağıtıcı unsurlar olmadan sunum
- 👆 **Çift Tıklama Navigasyonu**: Hızlı menü geçişi
- 🌓 **Dark Theme**: Modern ve göz dostu arayüz
- 📊 **Geri Sayım Göstergesi**: Her slayt için kalan süre bilgisi

## 🛠️ Kullanılan Teknolojiler

### Framework & Dil
- **Flutter** 3.6.0
- **Dart** SDK

### Paketler
```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^0.8.5+3  # Galeri ve kamera erişimi için
  fluttertoast: ^8.0.9    # Kullanıcı bildirimleri için
  cupertino_icons: ^1.0.8 # iOS stil ikonlar
```

## 🚀 Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK (≥3.6.0)
- Android Studio / VS Code
- Git

### Kurulum Adımları

1. **Repository'yi klonlayın:**
```bash
git clone https://github.com/[kullaniciadi]/offering_project.git
cd offering_project
```

2. **Bağımlılıkları yükleyin:**
```bash
flutter pub get
```

3. **Uygulamayı çalıştırın:**
```bash
flutter run
```

## 📱 Kullanım Kılavuzu

### 1. Ana Ekran
- "Proceed to create a presentation" butonuna tıklayarak başlayın

### 2. Sunum Oluşturma
1. **Resim Seçimi**: "Resim Seçin" butonu ile galeriden resimlerinizi seçin
2. **Slayt Düzenleme**:
   - ⏱️ Timer ikonu → Geçiş süresini ayarlayın (Slider ile 1-10 saniye)
   - 🎨 Animation ikonu → Geçiş efekti seçin (Fade/Slide/Zoom)
   - 🗑️ Delete ikonu → Slaytı kaldırın
   - Sürükle-bırak ile sıralamayı değiştirin

### 3. Slayt Yönetimi
- 🔀 **Shuffle**: Slaytları karıştırın
- 💾 **Save**: Sunumu kaydedin
- 🗑️ **Clear**: Tüm slaytları temizleyin

### 4. Sunum Oynatma
1. "Start" butonu ile sunumu başlatın
2. Otomatik geçişleri izleyin
3. "Stop" butonu ile durdurun
4. Çift tıklama ile ana menüye dönün

### 5. Çalışma Zamanlayıcısı
- Süre girin (saniye cinsinden)
- "Çalışma Süresini Başlat" butonuna tıklayın
- Süre dolunca otomatik olarak ana menüye dönersiniz

## 🏗️ Proje Yapısı

```
offering_project/
├── lib/
│   └── main.dart              # Ana uygulama kodu
├── android/                   # Android platform dosyaları
├── ios/                       # iOS platform dosyaları
├── web/                       # Web platform dosyaları
├── test/                      # Test dosyaları
├── pubspec.yaml              # Proje bağımlılıkları
└── README.md                 # Proje dokümantasyonu
```

## 🎯 Kod Yapısı

### Widget Hiyerarşisi
```
MyApp (MaterialApp)
└── MainScreen
    └── ImageSliderScreen
        ├── Image Picker
        ├── ReorderableListView (Slayt listesi)
        ├── Animation Controller
        └── Timer Management
```

### Önemli Sınıflar

#### `MyApp`
- MaterialApp root widget'ı
- Dark theme konfigürasyonu

#### `MainScreen`
- Ana menü ekranı
- Settings dialog'u
- Navigation kontrolü

#### `ImageSliderScreen` (StatefulWidget)
- **State Değişkenleri:**
  - `List<Uint8List> _images` → Seçilen resimler
  - `List<int> _intervals` → Her slayt için süre
  - `List<String> _animations` → Her slayt için animasyon tipi
  - `int _currentIndex` → Aktif slayt indexi
  - `bool _isSliding` → Sunum durumu
  - `Timer? _timer` → Slayt geçiş timer'ı
  - `Timer? _workTimer` → Çalışma süresi timer'ı

- **Önemli Metodlar:**
  - `_pickImages()` → ImagePicker ile resim seçimi
  - `_startSlider()` → Sunum başlatma
  - `_stopSlider()` → Sunum durdurma
  - `_shuffleImages()` → Karıştırma
  - `_getAnimatedImage()` → Animasyon uygulama
  - `_startWorkTimer()` → Zamanlayıcı başlatma

## 🎨 Özellik Detayları

### Animasyon Tipleri
| Animasyon | Açıklama | Widget |
|-----------|----------|--------|
| Fade | Yumuşak soldurma efekti | `FadeTransition` |
| Slide | Kaydırma geçişi | `SlideTransition` |
| Zoom | Yakınlaştırma efekti | `ScaleTransition` |

### Süre Ayarları
- **Minimum:** 1 saniye
- **Maksimum:** 10 saniye
- **Varsayılan:** 2 saniye
- **Ayarlama:** Slider ile

## 📱 Platform Desteği

| Platform | Durum |
|----------|-------|
| Android | ✅ Tam destek |
| iOS | ✅ Tam destek |
| Web | ⚠️ Kısıtlı (Image picker sınırlı) |
| Windows | ✅ Desktop desteği |
| macOS | ✅ Desktop desteği |
| Linux | ✅ Desktop desteği |

## 🔮 Gelecek Geliştirmeler

- [ ] Video slayt desteği
- [ ] Background müzik ekleme
- [ ] Cloud storage entegrasyonu
- [ ] PDF/Video export
- [ ] Daha fazla animasyon efekti
- [ ] Tema özelleştirme seçenekleri
- [ ] Slayt notları ekleme
- [ ] Şablon galerisi

## 📚 Öğrenilen Konular

Bu proje geliştirilirken aşağıdaki Flutter konuları uygulamalı olarak öğrenilmiştir:

- State Management (StatefulWidget)
- Image Picker entegrasyonu
- Timer kullanımı
- ReorderableListView ile drag & drop
- Custom animations (Fade, Slide, Zoom)
- Navigation ve routing
- Dialog ve AlertDialog kullanımı
- GestureDetector (double tap)
- Async/await operations
- Material Design components

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/YeniOzellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/YeniOzellik`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje eğitim amaçlı geliştirilmiştir.

## 📧 İletişim

**Mehmet DOĞAN**  
e-mail: mehmetdogan.dev@gmail.com

Sorularınız için GitHub Issues kullanabilirsiniz.

---

⭐ Projeyi beğendiyseniz yıldız vermeyi unutmayın!

**Son Güncelleme:** Ekim 2025