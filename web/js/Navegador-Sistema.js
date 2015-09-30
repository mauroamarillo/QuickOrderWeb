function NavegadorSistema() {
    // ---- Propiedades del Browser -----
    this.fullName = 'unknow';// nombre del navegador
    this.name = 'unknow';
    this.code = 'unknow';
    this.platform = 'unknow';// nombre del sistema utilizado
    // ------- inicializar -------    
    this.init = function () {
         var navs = [
            {name: 'Opera Mobi', fullName: 'Opera Mobile', pre: 'Version/'},
            {name: 'Opera Mini', fullName: 'Opera Mini', pre: 'Version/'},
            {name: 'Opera', fullName: 'Opera', pre: 'Version/'},
            {name: 'MSIE', fullName: 'Microsoft Internet Explorer', pre: 'MSIE '},
            {name: 'BlackBerry', fullName: 'BlackBerry Navigator', pre: '/'},
            {name: 'BrowserNG', fullName: 'Nokia Navigator', pre: 'BrowserNG/'},
            {name: 'Midori', fullName: 'Midori', pre: 'Midori/'},
            {name: 'Kazehakase', fullName: 'Kazehakase', pre: 'Kazehakase/'},
            {name: 'Chromium', fullName: 'Chromium', pre: 'Chromium/'},
            {name: 'Flock', fullName: 'Flock', pre: 'Flock/'},
            {name: 'Galeon', fullName: 'Galeon', pre: 'Galeon/'},
            {name: 'RockMelt', fullName: 'RockMelt', pre: 'RockMelt/'},
            {name: 'Fennec', fullName: 'Fennec', pre: 'Fennec/'},
            {name: 'Konqueror', fullName: 'Konqueror', pre: 'Konqueror/'},
            {name: 'Arora', fullName: 'Arora', pre: 'Arora/'},
            {name: 'Swiftfox', fullName: 'Swiftfox', pre: 'Firefox/'},
            {name: 'Maxthon', fullName: 'Maxthon', pre: 'Maxthon/'},
            // { name:'', fullName:'', pre:'' } //add new broswers
            // { name:'', fullName:'', pre:'' }
            {name: 'Firefox', fullName: 'Mozilla Firefox', pre: 'Firefox/'},
            {name: 'Chrome', fullName: 'Google Chrome', pre: 'Chrome/'},
            {name: 'Safari', fullName: 'Apple Safari', pre: 'Version/'}
        ];

        var agent = navigator.userAgent, pre;
        //busca el nombre del explorador dentro del array de arriba
        for (var i in navs) {
            if (agent.indexOf(navs[i].name) > -1) {
                pre = navs[i].pre;
                this.name = navs[i].name.toLowerCase();// el codigo va en minusculas
                this.fullName = navs[i].fullName;
                if (this.name === 'msie')
                    this.name = 'iexplorer';
                if (this.name === 'opera mobi')
                    this.name = 'opera';
                if (this.name === 'opera mini')
                    this.name = 'opera';
                break; //cuando encuentra el nombre sale
            }
        }
        // settear Plataforma     
        var plat = navigator.platform;
        if (plat === 'Win32' || plat === 'Win64')
            this.platform = 'Windows';
        if (agent.indexOf('NT 5.1') !== -1)
            this.platform = 'Windows XP';
        if (agent.indexOf('NT 6') !== -1)
            this.platform = 'Windows Vista';
        if (agent.indexOf('NT 6.1') !== -1)
            this.platform = 'Windows 7';
        if (agent.indexOf('NT 6.2') !== -1)
            this.platform = 'Windows 8';
        if (agent.indexOf('NT 10.0') !== -1)
            this.platform = 'Windows 10';
        if (agent.indexOf('Mac') !== -1)
            this.platform = 'Macintosh';
        if (agent.indexOf('Linux') !== -1)
            this.platform = 'Linux';
        if (agent.indexOf('iPhone') !== -1)
            this.platform = 'iOS iPhone';
        if (agent.indexOf('iPod') !== -1)
            this.platform = 'iOS iPod';
        if (agent.indexOf('iPad') !== -1)
            this.platform = 'iOS iPad';
        if (agent.indexOf('Android') !== -1)
            this.platform = 'Android';

    };
    this.init();
}