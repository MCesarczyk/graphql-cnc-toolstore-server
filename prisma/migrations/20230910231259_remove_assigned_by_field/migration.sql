/*
  Warnings:

  - You are about to drop the column `assignedBy` on the `CollectionsOnProduct` table. All the data in the column will be lost.
  - You are about to drop the column `assignedBy` on the `CategoriesOnProduct` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CollectionsOnProduct" (
    "productId" TEXT NOT NULL,
    "collectionId" TEXT NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "CollectionsOnProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "CollectionsOnProduct_collectionId_fkey" FOREIGN KEY ("collectionId") REFERENCES "Collection" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CollectionsOnProduct" ("assignedAt", "collectionId", "productId") SELECT "assignedAt", "collectionId", "productId" FROM "CollectionsOnProduct";
DROP TABLE "CollectionsOnProduct";
ALTER TABLE "new_CollectionsOnProduct" RENAME TO "CollectionsOnProduct";
CREATE UNIQUE INDEX "CollectionsOnProduct_productId_collectionId_key" ON "CollectionsOnProduct"("productId", "collectionId");
CREATE TABLE "new_CategoriesOnProduct" (
    "productId" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "CategoriesOnProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "CategoriesOnProduct_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CategoriesOnProduct" ("assignedAt", "categoryId", "productId") SELECT "assignedAt", "categoryId", "productId" FROM "CategoriesOnProduct";
DROP TABLE "CategoriesOnProduct";
ALTER TABLE "new_CategoriesOnProduct" RENAME TO "CategoriesOnProduct";
CREATE UNIQUE INDEX "CategoriesOnProduct_productId_categoryId_key" ON "CategoriesOnProduct"("productId", "categoryId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
