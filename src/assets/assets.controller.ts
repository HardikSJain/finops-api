import { Controller, Get, Post, Body, Param, Query } from '@nestjs/common';
import { AssetsService } from './assets.service';
import { CreateAssetDto } from './dto/create-asset.dto';

@Controller('assets')
export class AssetsController {
  constructor(private readonly assetsService: AssetsService) {}

  @Post()
  create(@Body() data: CreateAssetDto) {
    return this.assetsService.create(data);
  }

  @Get()
  findAll(@Query('class') assetClass?: string) {
    if (assetClass) return this.assetsService.findByClass(assetClass);
    return this.assetsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.assetsService.findOne(id);
  }
}
