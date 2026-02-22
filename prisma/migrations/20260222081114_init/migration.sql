-- CreateEnum
CREATE TYPE "AssetClass" AS ENUM ('CASH', 'EQUITY', 'MF', 'ETF', 'DEBT', 'GOLD', 'CRYPTO', 'EPF', 'NPS', 'OTHER');

-- CreateEnum
CREATE TYPE "TxType" AS ENUM ('BUY', 'SELL', 'DIVIDEND', 'INTEREST', 'DEPOSIT', 'WITHDRAWAL', 'TRANSFER', 'FEE', 'TAX', 'SALARY', 'EXPENSE');

-- CreateTable
CREATE TABLE "accounts" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "institution" TEXT,
    "accountType" TEXT,
    "currency" TEXT NOT NULL DEFAULT 'INR',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "assets" (
    "id" TEXT NOT NULL,
    "symbol" TEXT,
    "name" TEXT NOT NULL,
    "assetClass" "AssetClass" NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'INR',
    "metadata" JSONB NOT NULL DEFAULT '{}',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "assets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "id" TEXT NOT NULL,
    "txDate" DATE NOT NULL,
    "accountId" TEXT NOT NULL,
    "assetId" TEXT,
    "txType" "TxType" NOT NULL,
    "quantity" DECIMAL(20,8),
    "price" DECIMAL(20,8),
    "amount" DECIMAL(20,2) NOT NULL,
    "fees" DECIMAL(20,2) NOT NULL DEFAULT 0,
    "taxes" DECIMAL(20,2) NOT NULL DEFAULT 0,
    "notes" TEXT,
    "externalRef" TEXT,
    "source" TEXT NOT NULL DEFAULT 'manual',
    "raw" JSONB NOT NULL DEFAULT '{}',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "asset_prices" (
    "assetId" TEXT NOT NULL,
    "priceDate" DATE NOT NULL,
    "closePrice" DECIMAL(20,8) NOT NULL,
    "source" TEXT NOT NULL DEFAULT 'manual',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "asset_prices_pkey" PRIMARY KEY ("assetId","priceDate")
);

-- CreateIndex
CREATE UNIQUE INDEX "assets_symbol_currency_key" ON "assets"("symbol", "currency");

-- CreateIndex
CREATE UNIQUE INDEX "transactions_externalRef_key" ON "transactions"("externalRef");

-- CreateIndex
CREATE INDEX "transactions_accountId_txDate_idx" ON "transactions"("accountId", "txDate");

-- CreateIndex
CREATE INDEX "transactions_assetId_txDate_idx" ON "transactions"("assetId", "txDate");

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "accounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES "assets"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "asset_prices" ADD CONSTRAINT "asset_prices_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES "assets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
