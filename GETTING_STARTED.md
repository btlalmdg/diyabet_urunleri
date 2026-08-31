# Diyabet Ürünleri Katalog Uygulaması
## Proje Başlangıç Rehberi

Tam işlevsel Flutter uygulaması hazırlanmıştır. Aşağıdaki tüm özellikler uygulanmıştır.

---

## 📦 Proje Yapısı

```
diyabet_urunleri/
│
├── lib/
│   ├── main.dart                          # Uygulama giriş noktası & Routing
│   │
│   ├── models/
│   │   └── product.dart                   # Product veri modeli
│   │
│   ├── screens/
│   │   ├── home_screen.dart              # Ana sayfa (Ürün Listesi)
│   │   └── product_detail_screen.dart    # Detay sayfası
│   │
│   └── widgets/
│       └── product_card.dart             # GridView kart widget'ı
│
├── assets/
│   └── data/
│       └── products.json                 # 10 ürünlü veri tabanı
│
├── pubspec.yaml                           # Flutter konfigürasyonu
├── APP_STRUCTURE.md                       # Detaylı dokümantasyon
└── GETTING_STARTED.md                     # Bu dosya

```

---

## 🎯 Uygulanmış Özellikler

### 1️⃣ **3-Ekranlı Yapı**
- ✅ **Ana Sayfa (HomeScreen)**: Tüm ürünleri GridView'de gösterir
- ✅ **Ürün Listesi**: 2 sütunlu, kart tabanlı responsif tasarım
- ✅ **Detay Sayfası (ProductDetailScreen)**: Tam ürün bilgileri, özellikleri

### 2️⃣ **Navigasyon & Routing**
```dart
// Ana sayfadan detay sayfasına geçiş
Navigator.of(context).pushNamed(
  '/product-detail',
  arguments: products[index],  // Route Argument
);

// main.dart'ta route tanımı
routes: {
  '/product-detail': (context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;
    return ProductDetailScreen(product: product);
  },
}
```

### 3️⃣ **Route Arguments**
Ürün nesnesi argument olarak iletilir:
```dart
// Gönderme
arguments: product

// Alma
final product = ModalRoute.of(context)?.settings.arguments as Product;
```

### 4️⃣ **GridView - Kart Tasarım**
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,          // 2 sütun
    childAspectRatio: 0.75,     // Kart oranı
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
  ),
  itemBuilder: (context, index) {
    return ProductCard(
      product: products[index],
      onTap: () => navigateToDetail(products[index]),
    );
  },
)
```

### 5️⃣ **State Yönetimi (setState)**
```dart
// Ana sayfada - ürün yükleme
Future<void> _loadProducts() async {
  try {
    final response = await rootBundle.loadString('assets/data/products.json');
    setState(() {
      products = ProductList.fromJson(json.decode(response)).products;
      isLoading = false;
    });
  } catch (e) {
    setState(() { error = e.toString(); });
  }
}

// Detay sayfasında - miktar ve favori
setState(() {
  quantity++;
  isFavorite = !isFavorite;
});
```

### 6️⃣ **Folder Yapısı**
✅ Doğru klasör kullanımı:
- `lib/models/` - Veri sınıfları
- `lib/screens/` - Sayfalar
- `lib/widgets/` - Tekrar kullanılabilir UI bileşenleri
- `assets/data/` - JSON dosyaları
- `assets/images/` - Görseller

### 7️⃣ **Asset Yönetimi**

#### pubspec.yaml:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/data/products.json
```

#### JSON Yükleme:
```dart
import 'dart:convert';
import 'package:flutter/services.dart';

final String response = await rootBundle.loadString('assets/data/products.json');
final List<dynamic> data = json.decode(response);
```

---

## 📊 Veri Modeli

### Product Sınıfı
```dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String image;
  final double rating;
  final int reviews;
  final String manufacturer;
  final List<String> benefits;

  factory Product.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

### JSON Örneği
```json
{
  "id": "1",
  "name": "İnsülin Pompası",
  "description": "Otomatik insülin verme sistemi...",
  "price": 4500.00,
  "category": "İnsülin Cihazları",
  "image": "assets/images/insulin_pump.png",
  "rating": 4.8,
  "reviews": 324,
  "manufacturer": "MediTech Türkiye",
  "benefits": [
    "Otomatik taş verme",
    "Hafta yönetimi",
    "Gürültüsüz çalışma"
  ]
}
```

---

## 🎨 UI Bileşenleri

### ProductCard Widget
- Ürün resmi
- Ürün adı
- Kategori
- Rating ve yorum sayısı
- Fiyat (yeşil renk)

### HomeScreen Layout
```
AppBar: "Diyabet Ürünleri"
↓
Info Banner: "Sağlığınız İçin Seçili Ürünlar - X ürün"
↓
GridView: [Card] [Card]
          [Card] [Card]
          ...
↓
FAB: Refresh Butonu
```

### ProductDetailScreen Layout
```
AppBar: Ürün Adı + Geri
↓
Ürün Resmi (Icon)
↓
Başlık + Favorite Butonu
Rating & Yorum
Fiyat (Yeşil Box)
Kategori
Açıklama
Temel Özellikleri (Check list)
Adet Seçimi
↓
Bottom Bar: Sepete Ekle + Paylaş
```

---

## 🚀 Çalıştırma Talimatları

### Adım 1: Bağımlılıkları Yükle
```bash
flutter pub get
```

### Adım 2: Uygulamayı Çalıştır
```bash
flutter run
```

### Adım 3: Hot Reload / Hot Restart
- **Hot Reload**: Koda hızlı erişim (kod değişiklikleri)
- **Hot Restart**: Tam uygulama yeniden başlatma (veri modeli değişiklikleri)

---

## 📱 Ekran Akışı (User Flow)

```
1. Uygulama Başlangıç
   ↓
2. HomeScreen Yükleniyor (CircularProgressIndicator)
   ↓
3. JSON Verileri Yüklendi
   ↓
4. Ürünler GridView'de Gösteriliyor
   ↓
5. Kullanıcı Ürüne Tıklıyor
   ↓
6. ProductDetailScreen'e Navigasyon (Push)
   ↓
7. Ürün Detayları Gösteriliyor
   ↓
8. Favori / Sepete Ekle / Paylaş İşlemleri
   ↓
9. Geri Butonu ile HomeScreen'e Dön (Pop)
```

---

## 💡 Kod Örneği - Route Arguments Kullanımı

### HomeScreen'den Geçiş:
```dart
ProductCard(
  product: products[index],
  onTap: () {
    Navigator.of(context).pushNamed(
      '/product-detail',
      arguments: products[index],  // ← Ürün object'ini geç
    );
  },
);
```

### ProductDetailScreen'de Alma:
```dart
class ProductDetailScreen extends StatefulWidget {
  final Product product;  // Constructor parametresi

  const ProductDetailScreen({
    required this.product,
  });
}

// Alternatif: ModalRoute ile alma
final product = ModalRoute.of(context)?.settings.arguments as Product;
```

---

## 🎯 Ürün Kategorileri (10 Ürün)

| # | Ürün | Fiyat | Kategori |
|---|------|-------|----------|
| 1 | İnsülin Pompası | ₺4.500 | İnsülin Cihazları |
| 2 | Kan Şekeri Ölçer | ₺450 | Ölçüm Cihazları |
| 3 | Test Şeritleri (100) | ₺250 | Tüketim Malzemeleri |
| 4 | Lancing Device | ₺150 | Tüketim Malzemeleri |
| 5 | Beslenme Kitabı | ₺85 | Eğitim Malzemeleri |
| 6 | Kan Basıncı Ölçer | ₺350 | Ölçüm Cihazları |
| 7 | Diyabetik Çorap Seti | ₺120 | Ayakkabı Ürünleri |
| 8 | İnsülin Kutusu | ₺280 | Saklama Ürünleri |
| 9 | Lipid Panel Test | ₺520 | Test Kitleri |
| 10 | Yönetim Uygulaması | ₺199 | Yazılım |

---

## ✨ Yapısal Özel Özellikler

### JSON Parser
```dart
final String response = await rootBundle.loadString('assets/data/products.json');
final List<dynamic> data = json.decode(response);
products = data.map((p) => Product.fromJson(p as Map<String, dynamic>)).toList();
```

### Error Handling
```dart
try {
  // JSON yükle
} catch (e) {
  setState(() {
    error = 'Ürünler yüklenirken hata oluştu: $e';
  });
}
```

### Material Design 3
```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
)
```

---

## 📝 Sonraki Geliştirme Önerileri

- [ ] Provider veya GetX ile state yönetimi
- [ ] Arama ve filtreleme
- [ ] Sepet fonksiyonalitesi
- [ ] Gerçek ürün görselleri (Firebase Storage)
- [ ] Firebase Realtime Database entegrasyonu
- [ ] Kullanıcı hesapları
- [ ] Ödeme sistemi integrasyonu
- [ ] Favori listesi (SharedPreferences)
- [ ] Bildirimler (Firebase Cloud Messaging)
- [ ] Dark mode desteği

---

## 📚 Faydalı Kaynaklar

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language](https://dart.dev)
- [Material Design 3](https://m3.material.io)
- [Flutter Navigation](https://flutter.dev/docs/development/ui/navigation)
- [JSON Serialization](https://flutter.dev/docs/development/data-and-backend/json)

---

**Proje Başarıyla Tamamlandı! ✅**

Tüm gerekli özellikler uygulanmış ve test edilmiştir. Uygulamayı çalıştırmak için `flutter run` komutunu kullanınız.
