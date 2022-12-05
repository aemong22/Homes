<template>
  <body>
    <div class="header">Header</div>

    <div class="container">
      <div class="content">Main content</div>
      <div class="sidebar">Sticky Sidebar</div>
    </div>

    <div class="footer">Footer</div>
  </body>
</template>

<script>
export default {};
</script>

<style>
html,
body {
  margin: 0;
}

.header {
  height: 80px;
  background: burlywood;
}

.container {
  display: flex;
  flex-flow: row nowrap;
}

.content {
  width: 80%;
  height: 800px;
  background: #f5f5f5;
}

.sidebar {
  width: 20%;
  height: 400px;
  position: sticky;
  top: 0;
  background: yellowgreen;
}

.footer {
  background: #333;
  height: 200px;
}
</style>
