/*
  Warnings:

  - You are about to drop the `CategoriesOnCarBlogs` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "CategoriesOnCarBlogs";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "_CarBlogToCategoryCarBlogs" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CarBlogToCategoryCarBlogs_A_fkey" FOREIGN KEY ("A") REFERENCES "CarBlog" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CarBlogToCategoryCarBlogs_B_fkey" FOREIGN KEY ("B") REFERENCES "CategoryCarBlogs" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "fname" TEXT NOT NULL,
    "lname" TEXT NOT NULL,
    "friendId" TEXT,
    CONSTRAINT "User_friendId_fkey" FOREIGN KEY ("friendId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("fname", "id", "lname") SELECT "fname", "id", "lname" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_friendId_key" ON "User"("friendId");
CREATE TABLE "new_CarBlog" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "content" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    CONSTRAINT "CarBlog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_CarBlog" ("content", "createdAt", "id", "userId") SELECT "content", "createdAt", "id", "userId" FROM "CarBlog";
DROP TABLE "CarBlog";
ALTER TABLE "new_CarBlog" RENAME TO "CarBlog";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_CarBlogToCategoryCarBlogs_AB_unique" ON "_CarBlogToCategoryCarBlogs"("A", "B");

-- CreateIndex
CREATE INDEX "_CarBlogToCategoryCarBlogs_B_index" ON "_CarBlogToCategoryCarBlogs"("B");
