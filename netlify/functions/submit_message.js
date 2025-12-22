const { Client } = require('pg');

exports.handler = async (event, context) => {
  // السماح فقط بطلبات POST
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method Not Allowed' };
  }

  try {
    // استقبال البيانات من فلاتر
    const { email, message } = JSON.parse(event.body);

    // التحقق من البيانات
    if (!email || !message) {
      return { statusCode: 400, body: 'Email and message are required' };
    }

    // الاتصال بـ Neon
    // DATABASE_URL هو المتغير الذي وفره Netlify تلقائياً عند الربط
    const client = new Client({
      connectionString: process.env.NETLIFY_DATABASE_URL,
      ssl: { rejectUnauthorized: false }, // ضروري لـ Neon
    });

    await client.connect();

    // إدخال البيانات في الجدول
    const query = 'INSERT INTO messages (email, message) VALUES ($1, $2)';
    await client.query(query, [email, message]);

    await client.end();

    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Message sent successfully!' }),
    };

  } catch (error) {
    console.error('Error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Failed to send message' }),
    };
  }
};