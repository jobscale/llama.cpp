const { ro } = require('./setting.json');

const logger = console;

class App {
  async main() {
    logger.info(Buffer.from(ro, 'base64').toString());
  }
}

new App().main();
