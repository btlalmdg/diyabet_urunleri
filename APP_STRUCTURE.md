# Diyabet Ürünleri Katalog Uygulaması

Diyabet ürünleri için tam işlevsel bir mobil katalog uygulaması. Flutter ile geliştirilmiş, modern tasarım ve kolay navigasyon özelliklerine sahiptir.

## Özellikler

✅ **Ana Sayfa** - Ürün listesi GridView ile gösterilir
✅ **Ürün Detay Sayfası** - Route Arguments kullanılarak ürün geçişleri yapılır
✅ **Navigator** - Sayfalar arasında geçiş ve geri dönüş
✅ **GridView** - Kart tabanlı responsif tasarım
✅ **State Yönetimi** - Basit setState ile state güncellemeleri
✅ **Asset Yönetimi** - JSON veri ve resim dosyaları organize edilmiş
✅ **Modern UI** - Material Design 3 ile kullanıcı arayüzü

## Proje Yapısı

```
lib/
├── main.dart                 # Uygulama giriş noktası ve routing
├── models/
│   └── product.dart         # Product ve ProductList veri modelleri
├── screens/
│   ├── home_screen.dart     # Ana sayfa - ürün listesi
│   └── product_detail_screen.dart  # Ürün detay sayfası
└── widgets/
    └── product_card.dart    # GridView kartı widget'ı

assets/
├── data/
│   └── products.json        # Ürün verileri JSON formatında
└── images/                  # Ürün görselleri (isteğe bağlı)
```

## Veri Modeli (Product)

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
}
```

## Önemli Bileşenler

### 1. **HomeScreen** (Ana Sayfa)
- JSON dosyasından ürünleri yükler
- GridView ile 2 sütunlu düzen
- Refresh butonu ile yeniden yükleme
- Shimmer loading efekti

### 2. **ProductDetailScreen** (Ürün Detayı)
- Route Arguments ile ürün geçişi
- Favorilere ekleme/çıkarma
- Adet seçimi ve sepete ekleme
- Ürün özellikleri ve faydaları gösterir

### 3. **ProductCard** (Kart Widget'ı)
- Responsif tasarım
- Resim, fiyat ve rating gösterimi
- Tap edilebilir ve tıklanabilir

## Kullanılan Teknolojiler

- **Flutter** - UI Framework
- **Dart** - Programlama Dili
- **Material Design 3** - Tasarım Sistemi
- **JSON** - Veri Formatı
- **Navigator 2.0** - Sayfalar Arası Geçiş

## Routing Yapısı

```dart
MaterialApp(
  home: HomeScreen(),     // Ana sayfa
  routes: {
    '/product-detail': (context) {
      final product = ModalRoute.of(context)?.settings.arguments as Product;
      return ProductDetailScreen(product: product);
    },
  },
)
```

### Sayfalar Arası Geçiş
```dart
// Ürün detayına git
Navigator.of(context).pushNamed(
  '/product-detail',
  arguments: product,  // Route Argument olarak ürün gönder
);

// Geri dön
Navigator.of(context).pop();
```

## Ürün Kategorileri

1. İnsülin Cihazları
2. Ölçüm Cihazları
3. Tüketim Malzemeleri
4. Eğitim Malzemeleri
5. Ayakkabı Ürünleri
6. Saklama Ürünleri
7. Test Kitleri
8. Yazılım Lisansları

## State Yönetimi

Uygulama basit `setState` kullanımı ile state güncellemeleri yapır:

```dart
// HomeScreen - Ürün listesi yükleme
setState(() {
  products = data;
  isLoading = false;
});

// ProductDetailScreen - Miktar ve favori durumu
setState(() {
  quantity++;
  isFavorite = !isFavorite;
});
```

## Asset Yönetimi

### pubspec.yaml Konfigürasyonu
```yaml
flutter:
  assets:
    - assets/data/products.json
```

### JSON Veri Yükleme
```dart
final String response = await rootBundle.loadString('assets/data/products.json');
final List<dynamic> data = json.decode(response);
final products = data.map((p) => Product.fromJson(p)).toList();
```

## Kurulum ve Çalıştırma

```bash
# Bağımlılıkları yükle
flutter pub get

# Uygulamayı çalıştır
flutter run

# Belirli device'da çalıştır
flutter run -d <device_id>
```

## Uygulamanın Akışı

1. **Başlangıç** → HomeScreen açılır
2. **Ürün Yükleme** → JSON dosyasından veriler okunur
3. **Liste Gösterimi** → GridView ile kartlar gösterilir
4. **Ürün Seçme** → Karta tıklanır
5. **Navigasyon** → Product Arguments ile ProductDetailScreen'e geçilir
6. **Detay Görüntüleme** → Ürün bilgileri, özelikleri, fiyat gösterilir
7. **İşlemler** → Sepete ekleme, favorileme, paylaşma

## Responsive Tasarım

- **GridView**: 2 sütunlu düzen, tüm ekran boyutlarına uyum
- **SingleChildScrollView**: Uzun içeriğin kaydırılması
- **Flexible/Expanded**: Dinamik boyutlandırma
- **MediaQuery**: Ekran boyutuna göre ayarlama

## Hata Yönetimi

```dart
try {
  final data = json.decode(response);
  setState(() {
    products = data;
  });
} catch (e) {
  setState(() {
    error = 'Yükleme hatası: $e';
  });
}
```

## Sonraki Geliştirmeler

- 🔍 Arama ve filtreleme özelliği
- ❤️ Favori listesi
- 🛒 Sepet ve ödeme sistemi
- 📦 Sipariş takibi
- 👤 Kullanıcı hesapları
- 📸 Gerçek ürün görselleri
- 💬 Yorum ve derecelendirme
- 🌙 Dark mode desteği

## Lisans

Bu proje eğitim amaçlı oluşturulmuştur.
