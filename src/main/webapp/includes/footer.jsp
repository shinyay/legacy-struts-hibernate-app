<!-- Loading Indicator -->
<div id="loading" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%);
     background:rgba(0,0,0,0.7); color:white; padding:20px; border-radius:5px; z-index:9999;">
    <div style="text-align:center;">
        <div class="spinner"></div>
        <p>Loading...</p>
    </div>
</div>

<style>
.spinner {
    border: 4px solid #f3f3f3;
    border-top: 4px solid #3498db;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    animation: spin 1s linear infinite;
    margin: 0 auto 10px;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
</style>
