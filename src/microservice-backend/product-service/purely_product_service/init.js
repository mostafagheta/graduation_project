// 🔹 الاتصال بقاعدة البيانات مع المصادقة
db = connect("mongodb://root:example@localhost:27017/purely_product_service?authSource=admin");

// 🔹 حذف أي بيانات قديمة في المجموعة
db.products.drop();

// 🔹 قراءة ملف JSON من المسار الصحيح
var products = cat('/docker-entrypoint-initdb.d/purely_product_service.products.json');

// 🔹 تحويل البيانات إلى JSON
var parsedProducts = JSON.parse(products);

// 🔹 تصحيح _id ليكون ObjectId بدلاً من $oid
parsedProducts = parsedProducts.map(item => {
    if (item._id && item._id.$oid) {
        item._id = ObjectId(item._id.$oid);
    }
    return item;
});

// 🔹 إدخال البيانات في مجموعة `products`
db.products.insertMany(parsedProducts);

print("✅ Products data inserted successfully!");
