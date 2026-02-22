import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '../generated/prisma/client';

@Injectable()
export class AssetsService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.AssetCreateInput) {
    return this.prisma.asset.create({ data });
  }

  async findAll() {
    return this.prisma.asset.findMany({
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: string) {
    return this.prisma.asset.findUnique({ where: { id } });
  }

  async findByClass(assetClass: string) {
    return this.prisma.asset.findMany({
      where: { assetClass: assetClass as any },
      orderBy: { name: 'asc' },
    });
  }
}
