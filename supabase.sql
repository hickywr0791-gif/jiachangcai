-- 家常菜点菜系统 - 数据库建表脚本
-- 在 Supabase SQL Editor 中粘贴运行，可重复执行

-- 菜品表
CREATE TABLE IF NOT EXISTS dishes (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT DEFAULT '',
  image_url TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 订单表
CREATE TABLE IF NOT EXISTS orders (
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

-- 先清理旧策略，确保可重复执行
DROP POLICY IF EXISTS "Anyone can read dishes" ON dishes;
DROP POLICY IF EXISTS "Anyone can insert dishes" ON dishes;
DROP POLICY IF EXISTS "Anyone can delete dishes" ON dishes;
DROP POLICY IF EXISTS "Anyone can insert orders" ON orders;
DROP POLICY IF EXISTS "Anyone can read orders" ON orders;
DROP POLICY IF EXISTS "Anyone can update orders" ON orders;

-- dishes: 所有人可读
CREATE POLICY "Anyone can read dishes" ON dishes
  FOR SELECT USING (true);

-- dishes: 厨师可添加（通过前端密码门控）
CREATE POLICY "Anyone can insert dishes" ON dishes
  FOR INSERT WITH CHECK (true);

-- dishes: 厨师可删除（通过前端密码门控）
CREATE POLICY "Anyone can delete dishes" ON dishes
  FOR DELETE USING (true);

-- orders: 食客可写
CREATE POLICY "Anyone can insert orders" ON orders
  FOR INSERT WITH CHECK (true);

-- orders: 所有人可读
CREATE POLICY "Anyone can read orders" ON orders
  FOR SELECT USING (true);

-- orders: 厨师可更新（通过前端密码门控）
CREATE POLICY "Anyone can update orders" ON orders
  FOR UPDATE USING (true);
