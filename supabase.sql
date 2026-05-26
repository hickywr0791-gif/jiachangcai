-- 家常菜点菜系统 - 数据库建表脚本
-- 在 Supabase SQL Editor 中粘贴运行

-- 菜品表
CREATE TABLE dishes (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT DEFAULT '',
  image_url TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 订单表
CREATE TABLE orders (
  id BIGSERIAL PRIMARY KEY,
  dishes JSONB NOT NULL DEFAULT '[]',
  time_slot TEXT NOT NULL DEFAULT '',
  note TEXT DEFAULT '',
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 开启行级安全
ALTER TABLE dishes ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- 食客可以读菜品
CREATE POLICY "Anyone can read dishes" ON dishes
  FOR SELECT USING (true);

-- 食客可以写订单
CREATE POLICY "Anyone can insert orders" ON orders
  FOR INSERT WITH CHECK (true);
